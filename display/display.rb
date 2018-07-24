require 'byebug'
require_relative "board"
require_relative "cursor"
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end

  def render(selected_piece)
    system("clear")
    puts
    (0...board.grid.length).each do |row|
      (0...board.grid[row].length).each do |col|
        render_position(row, col, selected_piece)
      end
      print "\n"
    end
    puts
  end

  private

  def render_position(row, col, selected_piece)
    piece = board[[row, col]]
    b_color = select_background_color([row, col], selected_piece)

    if selected_piece == piece
      print((board[[row, col]].symbol + " ").colorize(color: piece.color, background: b_color).bold.blink)
    else
      print((board[[row, col]].symbol + " ").colorize(color: piece.color, background: b_color).bold)
    end
  end

  def select_background_color(pos, selected_piece)
    if pos == cursor.cursor_pos
      b_color = :light_yellow
    elsif selected_piece && selected_piece.moves.include?(pos)
      if pos[0].even?
        b_color = pos[1].even? ? :light_green : :light_magenta
      else
        b_color = pos[1].even? ? :light_magenta : :light_green
      end
    else
      b_color = (pos[0].even? ? even_pattern(pos[1]) : odd_pattern(pos[1]))
    end
  end

  def even_pattern(col_num)
    col_num.even? ? :light_red : :light_cyan
  end

  def odd_pattern(col_num)
    col_num.odd? ? :light_red : :light_cyan
  end

end
