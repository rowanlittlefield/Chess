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
    # system("clear")
    puts "\u2618".colorize(color: :green) + "\u2102" + "\u210B" + " " + "\u2107" + "\u222C" + "\u2618".colorize(color: :green)
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
board.move_piece([6, 4], [3,3])
# board.move_piece([7, 3], [6, 4])
board.move_piece([0, 0], [4, 4])

display.render
 # board[[6, 4]].moves
p board[[7, 6]].valid_moves
