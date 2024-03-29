require 'curses'
include Curses

module Interface

    class Program
        def initialize
            @height = Curses.lines
            @width = Curses.cols
            @pos_x = 0
            @pos_y = 0
            @main_window = Window.new(@height, @width, 0, 0)
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
                end
        
                # draw and refresh affected windows
                @form.f_refresh
                @display.cd_refresh
                @grid.cg_refresh
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
            @id_w.addstr("Formula [0, 0]")
            @id_w.setpos(0, @id_w_len - 10)
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
            @id_w.addstr("Value [0, 0]")
            @id_w.setpos(0, @id_w_len - 10)
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
            @col_first = 8 # arbitrarily chosen spacing
            @col_step = 10 # arbitrarily chosen spacing
            @row_first = 1
        end

        def cg_refresh
            i = 0
            (@col_first...(@width - 1)).step(@col_step) do |column| # populates column indices
                @w.setpos(0, column)
                @w.addstr("#{i}")
                i += 1
            end
            ((@col_first / 2)...(@width)).step(@col_step) do |column| # populates column-separators
                vertical_line(@w, column, 0, @height)
                @w.setpos(2, column + 1)
                @w.addstr("#{(column + 1234.5678910111213).truncate(@col_step - 1)}") # TODO: REMOVE THIS, IT IS A TEMPORARY SOLUTION
            end
            

            (@row_first...(@height)).step(2) do |row| # populates row-separators
                horizontal_line(@w, row, 0, @width)
            end
            i = 0
            ((@row_first + 1)...(@height - 1)).step(2) do |row| # populates row indices
                @w.setpos(row, 0)
                @w.addstr("#{i}")
                i += 1
            end
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