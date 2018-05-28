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
    (0...board.grid.length).each do |i|
      (0...board.grid[i].length).each do |j|
        piece = board[[i, j]]
        p_color = piece.color
        b_color = (i.even? ? even_pattern(j) : odd_pattern(j))
        print board[[i, j]].symbol.colorize(color: p_color, background: b_color)
      end
      print "\n"
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
display.render
