require 'curses'
require_relative './ast.rb'
require_relative './interp.rb'

include Ast
include Interp
include Curses

module Interface
    # How do you choose between instance variables in Program or global
    # variables?
    $grid_row = 0
    $grid_col = 0
    $grid_size = 10
    $col_step = 14 # arbitrarily chosen spacing
    $col_first = $col_step / 2 # arbitrarily chosen spacing, half of col_step
    $row_step = 2 # skips the separator-line row
    $row_max = ($grid_size * 2) + 1

    class Program
        def initialize
            $grid = Grid.new($grid_size)

            @height = Curses.lines
            @width = Curses.cols
            @main_window = Window.new(@height, @width, 0, 0)
            @main_window.keypad(true)
            form_size = 14
            display_size = 2
            @form = FormulaEditor.new(form_size, @width, 0, 0, form_size)
            @display = CellDisplay.new(display_size, @width, form_size, 0, display_size)
            @grid_w = CellGrid.new(@height - (form_size + display_size), @width, form_size + display_size, 0)
        end
    
        def main_loop
            noecho
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
                elsif char == 'E'
                    @form.form_loop
                elsif char == 'R' # resets the current grid cell
                    Runtime.new($grid).set_cell(nil, CellAddressP.new($grid_row, $grid_col), nil)
                end
                
                # draw and refresh affected windows
                
                # Why not just call all the methods refresh instead of
                # prefixing them with redundant labels?
                @form.f_refresh
                @display.cd_refresh
                @grid_w.cg_refresh
                @main_window.setpos(0, 0)
            end
        end
    end

    class FormulaEditor

        def initialize(height, width, r_ind, c_ind, form_size)
            @height = height
            @width = width
            @form_size = form_size
            @id_w_len = @width / 8
            @w_len = @width - @id_w_len
            @id_w = Window.new(@height, @id_w_len, r_ind, c_ind)
            @w = Window.new(@height, @w_len, r_ind, @id_w_len)
        end

        def f_refresh
            col_end = $col_first + ($grid_size * $col_step) - @id_w_len
            @id_w.clear
            @w.clear
            @id_w.setpos((@form_size - 1) / 2, 0)
            @id_w.addstr("Formula [#{$grid_row}, #{$grid_col}]")

            vertical_line(@id_w, @id_w_len - 1, 1, @form_size)

            @w.setpos(1, 0)
            @w.addstr(get_formula($grid_row, $grid_col, @width))

            horizontal_line(@id_w, 0, 0, @id_w_len)
            horizontal_line(@id_w, @form_size - 1, 0, @id_w_len)
            horizontal_line(@w, 0, 0, col_end)
            horizontal_line(@w, @form_size - 1, 0, col_end)
            vertical_line(@w, col_end, 0, @form_size)

            @id_w.refresh
            @w.refresh
        end

        # Clean separation of event loops.
        def form_loop
            text = ''
            loop do
                @w.clear
                @w.refresh
                @w.setpos(1, 0)
                @w.addstr(text)
                char = @w.getch
                if char == '`' # cancel character
                    break
                elsif char == '@' # save/write character
                    save_cell(text)
                    break
                elsif char == 10 # enter key
                    text += "\n"
                elsif char == 127 # Backspace
                    text.chop!
                else
                    text += char.to_s
                end
            end
        end

        def save_cell(text)
            addr = CellAddressP.new($grid_row, $grid_col)
            run = Runtime.new($grid)
            if text[0] != '='
                if text == "True" || text == "False"
                    val = text.downcase == "true"
                    run.set_cell(text, addr, BooleanP.new(val))
                elsif text =~ /\A\d+\Z/
                    val = text.to_i
                    run.set_cell(text, addr, IntP.new(val))
                elsif text=~ /\A[+-]?\d+(\.\d+)?\z/
                    val = text.to_f
                    run.set_cell(text, addr, FloatP.new(val))
                else
                    val = "\"#{text.gsub("\n", "\\n ")}\""
                    run.set_cell(val, addr, StringP.new(val))
                end
            else
                text = text[1...]
                # So much power here in so few lines.
                begin
                    ast = lex_and_parse(text)
                    prim = evaluate(ast)
                    run.set_cell(text, addr, prim)
                rescue TypeError
                    run.set_cell(text, addr, nil)
                end
            end
        end
    end

    class CellDisplay

        def initialize(height, width, r_ind, c_ind, display_size)
            @height = height
            @width = width
            @display_size = display_size
            @id_w_len = @width / 8
            @w_len = @width - @id_w_len
            @id_w = Window.new(@height, @id_w_len, r_ind, c_ind)
            @w = Window.new(@height, @w_len, r_ind, @id_w_len)
        end

        def cd_refresh
            col_end = $col_first + ($grid_size * $col_step) - @id_w_len
            @id_w.setpos(0, 0)
            @id_w.addstr("Value [#{$grid_row}, #{$grid_col}]")
            @id_w.setpos(0, @id_w_len - 1)
            @id_w.addstr("\u2502")

            @w.setpos(0, 0)
            @w.addstr(display_cell($grid_row, $grid_col, @width, true))

            horizontal_line(@id_w, 1, 0, @id_w_len)
            horizontal_line(@w, 1, 0, col_end)
            vertical_line(@w, col_end, 0, @display_size)

            @id_w.refresh
            @w.refresh
        end
    end

    class CellGrid

        def initialize(height, width, r_ind, c_ind)
            @height = height
            @width = width
            @w = Window.new(@height, @width, r_ind, c_ind)
        end

        def cg_refresh
            draw_grid_template
            draw_grid_values
            @w.refresh
        end

        def draw_grid_template
            col_end = $col_first + ($grid_size * $col_step)
            # populates row-indices and horizontal-separators
            idx = 0
            # Clean traversal. A range and each. You could avoid the
            # conditional with two separate ranges/eaches.
            (1..$row_max).each do |row|
                if row % 2 == 0
                    @w.setpos(row, 2)
                    @w.addstr("#{idx}")
                    idx += 1
                else
                    horizontal_line(@w, row, 0, col_end)
                end
            end
            # populates column-indices and vertical-separators
            (0...$grid_size).each do |col| 
                @w.setpos(0, $col_step + (col * $col_step))
                @w.addstr("#{col}")
                vertical_line(@w, $col_first + (col * $col_step), 0, $row_max + 1)
            end
            vertical_line(@w, col_end, 0, $row_max + 1)
        end

        def draw_grid_values
            (0...$grid_size).each do |row|
                (0...$grid_size).each do |col|
                    row_idx = $row_step + (row * $row_step)
                    col_idx = ($col_first + 1) + (col * $col_step)
                    @w.setpos(row_idx, col_idx)
                    # Highlights currently selected row
                    if $grid_row == row && $grid_col == col
                        @w.attron(A_REVERSE)
                    end
                    @w.addstr(display_cell(row, col, $col_step, false))
                    @w.attroff(A_REVERSE)
                end
            end
        end
    end

    # Helper method for formula window
    def get_formula(row, col, max)
        s = ""
        addr = CellAddressP.new(row, col)
        run = Runtime.new($grid)
        source = run.get_cell(addr).code
        begin
            s = source == nil ? "   " : lex_and_parse(source).traverse(Serializer.new, Runtime.new($grid))
        rescue TypeError => error
            s = "ERROR: \n" ++ source
        end
        return truncate_s(s, max - 1).ljust((max - 1), ' ')
    end

    # Helper method for printing a horizontal line, used in window templates
    def horizontal_line(window, row, start_column, end_column)
        (start_column...end_column).each do |column|
        window.setpos(row, column)
        window.addstr("\u2500")
        end
    end

    # Helper method for printing a vertical line, used in window templates
    def vertical_line(window, column, start_row, end_row)
        (start_row...end_row).each do |row|
        window.setpos(row, column)
        window.addstr("\u2502")
        end
    end

    # Helper method for getting the value of a grid cell. Evaluates the cell every time.
    def display_cell(row, col, max, verbose)
        s = ""
        addr = CellAddressP.new(row, col)
        run = Runtime.new($grid)
        cell = run.get_cell(addr)
        if cell.most_recent_p == nil
            if cell.code == nil
                s = "   "
            else
                begin
                    ast = lex_and_parse(cell.code)
                    prim = evaluate(ast)
                    s = "#{prim.value}"
                rescue TypeError => error
                    s = verbose ? error.to_s : "ERROR"
                end
            end
        else
            begin
                ast = lex_and_parse(cell.code)
                prim = evaluate(ast)
                s = "#{prim.value}"
            rescue NoMethodError
                s = "Cannot be resolved to a primitive value"
            rescue TypeError => error
                s = verbose ? error.to_s : "ERROR"
            end
        end
        return truncate_s(s, max - 1).ljust((max - 1), ' ')
    end

    # Helper method for cutting down a string to a preferred size
    def truncate_s(s, max)
        # Ruby on Rails has a nice helper for truncate. Alas, plain Ruby does
        # not.
        s.length > max ? "#{s[0...max]}" : s
    end

    def lex_and_parse(source)
        lexer = Lexer.new(source)
        parser = Parser.new(lexer.lex)
        parser.parse
    end

    def evaluate(expression)
        expression.traverse(Evaluator.new, Runtime.new($grid))
    end
end

# Great implementation, Jack!
