require 'curses'
include Curses

module Interface
    $grid_row = 0
    $grid_col = 0
    $grid_size = 10

    class Program
        def initialize
            $runtime = Runtime.new
            $runtime.set_cell(CellAddressP.new(4,9), IntP.new(5)) # TODO: REMOVE THIS VALUE, IT IS A TEST

            @height = Curses.lines
            @width = Curses.cols
            @main_window = Window.new(@height, @width, 0, 0)
            @main_window.keypad(true)
            @form = FormulaEditor.new(2, @width, 0, 0)
            @display = CellDisplay.new(2, @width, 2, 0)
            @grid_w = CellGrid.new(@height - 4, @width, 4, 0)
        end
    
        def main_loop
            loop do
                @main_window.setpos(0, 0)
                char = @main_window.getch
                if char == 'q'
                    break
                # elsifs for other event triggers
                elsif char == Key::LEFT
                    $grid_col = $grid_col > 0 ? $grid_col - 1 : 0
                elsif char == Key::RIGHT
                    $grid_col = $grid_col < $grid_size - 1 ? $grid_col + 1 : $grid_col
                elsif char == Key::UP
                    $grid_row = $grid_row > 0 ? $grid_row - 1 : 0
                elsif char == Key::DOWN
                    $grid_row = $grid_row < $grid_size - 1 ? $grid_row + 1 : $grid_row
                end
                
                # draw and refresh affected windows
                @form.f_refresh
                @display.cd_refresh
                @grid_w.cg_refresh
                @main_window.setpos(0, @width - 50)
            end
        end
    
    end

    class FormulaEditor

        def initialize(height, width, r_ind, c_ind)
            @height = height
            @width = width
            @id_w_len = @width / 8
            @w_len = @width * (7 / 8)
            @id_w = Window.new(@height, @id_w_len, r_ind, c_ind)
            @w = Window.new(@height, @w_len, r_ind, @id_w_len)
        end

        def f_refresh
            @id_w.setpos(0, 0)
            @id_w.addstr("Formula [#{$grid_row}, #{$grid_col}]")
            @id_w.setpos(0, @id_w_len - 1)
            @id_w.addstr("\u2502")

            @w.setpos(0, 0)
            @w.addstr(get_cell_val_string($grid_row, $grid_col, @width))

            horizontal_line(@id_w, 1, 0, @id_w_len)
            horizontal_line(@w, 1, 0, @width)
            
            @id_w.refresh
            @w.refresh
        end
    end

    class CellDisplay

        def initialize(height, width, r_ind, c_ind)
            @height = height
            @width = width
            @id_w_len = @width / 8
            @w_len = @width * (7 / 8)
            @id_w = Window.new(@height, @id_w_len, r_ind, c_ind)
            @w = Window.new(@height, @w_len, r_ind, @id_w_len)
        end

        def cd_refresh
            @id_w.setpos(0, 0)
            @id_w.addstr("Value [#{$grid_row}, #{$grid_col}]")
            @id_w.setpos(0, @id_w_len - 1)
            @id_w.addstr("\u2502")

            @w.setpos(0, 0)
            @w.addstr(get_cell_val_string($grid_row, $grid_col, @width))

            horizontal_line(@id_w, 1, 0, @id_w_len)
            horizontal_line(@w, 1, 0, @width)

            @id_w.refresh
            @w.refresh
        end
    end

    class CellGrid

        def initialize(height, width, r_ind, c_ind)
            @height = height
            @width = width
            @w = Window.new(@height, @width, r_ind, c_ind)

            @col_step = 14 # arbitrarily chosen spacing
            @col_first = @col_step / 2 # arbitrarily chosen spacing, half of col_step
            @row_step = 2 # skips the separator-line row
            @row_max = ($grid_size * 2) + 1
        end

        def cg_refresh
            draw_grid_template
            draw_grid_values
            @w.refresh
        end

        def draw_grid_template
            # populates row-indices and horizontal-separators
            idx = 0
            (1..@row_max).each do |row|
                if row % 2 == 0
                    @w.setpos(row, 2)
                    @w.addstr("#{idx}")
                    idx += 1
                else
                    horizontal_line(@w, row, 0, @width)
                end
            end
            # populates column-indices and vertical-separators
            (0...$grid_size).each do |col| 
                @w.setpos(0, @col_step + (col * @col_step))
                @w.addstr("#{col}")
                vertical_line(@w, @col_first + (col * @col_step), 0, @row_max + 1)
            end
            vertical_line(@w, @col_first + ($grid_size * @col_step), 0, @row_max + 1)
        end

        def draw_grid_values
            (0...$grid_size).each do |row|
                (0...$grid_size).each do |col|
                    row_idx = @row_step + (row * @row_step)
                    col_idx = (@col_first + 1) + (col * @col_step)
                    @w.setpos(row_idx, col_idx)
                    if $grid_row == row && $grid_col == col
                        @w.attron(A_REVERSE)
                    end
                    @w.addstr(get_cell_val_string(row, col, @col_step))
                    @w.attroff(A_REVERSE)
                end
            end
        end
    end

    def get_cell_val_string(row, col, max)
        s = ""
        begin
            addr = CellAddressP.new(row, col)
            val = $runtime.get_cell(addr).value
            s = val.to_s
        rescue UndefGridError
            s = "NIL"
        end
        return truncate_s(s, max - 1).ljust((max - 1), ' ')
    end

    def horizontal_line(window, row, start_column, end_column)
        (start_column...end_column).each do |column|
        window.setpos(row, column)
        window.addstr("\u2500")
        end
    end

    def vertical_line(window, column, start_row, end_row)
        (start_row...end_row).each do |row|
        window.setpos(row, column)
        window.addstr("\u2502")
        end
    end

    # Helper method for cutting down a string to a preferred size
    def truncate_s(s, max)
        s.length > max ? "#{s[0...max]}" : s
    end
end