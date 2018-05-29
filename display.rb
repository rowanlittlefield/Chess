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
    (0...board.grid.length).each do |i|
      (0...board.grid[i].length).each do |j|
        piece = board[[i, j]]
        p_color = piece.color
        if [i, j] == cursor.cursor_pos
          b_color = :green
        else
          b_color = (i.even? ? even_pattern(j) : odd_pattern(j))
        end
        print board[[i, j]].symbol.colorize(color: p_color, background: b_color)
      end
      print "\n"
    end
    puts
  end

  def display_loop
    while true
      render
      cursor.get_input
    end

  end

  private
  def even_pattern(col_num)
    col_num.even? ? :red : :cyan
  end

  def odd_pattern(col_num)
    col_num.odd? ? :red : :cyan
  end

end

board = Board.new
display = Display.new(board)
# display.display_loop
p display.board.move_piece([0, 1], [4, 5])
display.render
p display.board[[4, 5]].moves
