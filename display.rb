require_relative "board"
require_relative "cursor"
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end

  def render
    system("clear")
    puts "\u2618".colorize(color: :green) + "\u2102" + "\u210B" + " " + "\u2107" + "\u222C" + "\u2618".colorize(color: :green)
    (0...board.grid.length).each do |i|
      (0...board.grid[i].length).each do |j|
        render_position(i, j)
      end
      print "\n"
    end
    puts #String.modes
  end

  private

  def render_position(row, col)
    piece = board[[row, col]]
    p_color = piece.color
    if [row, col] == cursor.cursor_pos
      b_color = :light_yellow
    else
      b_color = (row.even? ? even_pattern(col) : odd_pattern(col))
    end
    print((board[[row, col]].symbol + " ").colorize(color: p_color, background: b_color, bold: true))
  end

  def even_pattern(col_num)
    col_num.even? ? :light_red : :light_cyan
  end

  def odd_pattern(col_num)
    col_num.odd? ? :light_red : :light_cyan
  end

end
