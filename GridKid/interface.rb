require 'curses'
include Curses

module Interface
    $pos_x = 0
    $pos_y = 0
    $grid_size = 10

    class Program
        def initialize
            @height = Curses.lines
            @width = Curses.cols
            @main_window = Window.new(@height, @width, 0, 0)
            @main_window.keypad(true)
            @form = FormulaEditor.new(2, @width, 0, 0)
            @display = CellDisplay.new(2, @width, 2, 0)
            @grid = CellGrid.new(@height - 4, @width, 4, 0)
        end
    
        def main_loop
            loop do
                @main_window.setpos(0, 0)
                char = @main_window.getch
                if char == 'q'
                    break
                # elsifs for other event triggers
                elsif char == Key::LEFT
                    $pos_x = $pos_x > 0 ? $pos_x - 1 : 0
                elsif char == Key::RIGHT
                    $pos_x = $pos_x < $grid_size ? $pos_x + 1 : 0
                elsif char == Key::UP
                    $pos_y = $pos_y > 0 ? $pos_y - 1 : 0
                elsif char == Key::DOWN
                    $pos_y = $pos_y < $grid_size ? $pos_y + 1 : 0
                end
                
                # draw and refresh affected windows
                @form.f_refresh
                @display.cd_refresh
                @grid.cg_refresh
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
            @id_w.addstr("Formula [#{$pos_y}, #{$pos_x}]")
            @id_w.setpos(0, @id_w_len - 1)
            @id_w.addstr("\u2502")
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
            @id_w.addstr("Value [#{$pos_y}, #{$pos_x}]")
            @id_w.setpos(0, @id_w_len - 1)
            @id_w.addstr("\u2502")
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
            @col_first = 4 # arbitrarily chosen spacing, half of col_step
            @col_step = 8 # arbitrarily chosen spacing
            @row_max = ($grid_size * 2) + 1
        end

        def cg_refresh
            i = 0
            (1..@row_max).each do |row|
                if row % 2 == 0
                    @w.setpos(row, 2)
                    @w.addstr("#{i}")
                    i += 1
                else
                    horizontal_line(@w, row, 0, @width)
                end
            end


            (0...$grid_size).each do |col| # populates column-indices and vertical-separators
                @w.setpos(0, @col_step + (col * @col_step))
                @w.addstr("#{col}")
                vertical_line(@w, @col_first + (col * @col_step), 0, @row_max + 1)
            end
            vertical_line(@w, @col_first + ($grid_size * @col_step), 0, @row_max + 1)

            @w.refresh
        end
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
end