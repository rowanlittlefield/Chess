require "byebug"
require_relative "board"
require_relative "cursor"
require 'colorize'

class Display
  attr_reader :board, :cursor
  attr_accessor :inversion_coefficient

  def initialize(board)
    @board = board
    @cursor = Cursor.new([7,4],board)
    @inversion_coefficient = 0
  end

  def render(selected_piece)
    system("clear")
    puts
    (0...board.grid.length).each do |row|
      (0...board.grid[row].length).each do |col|
        transformed_row = (1 - @inversion_coefficient)*row + (@inversion_coefficient*(7 - row))
        transformed_col = (1 - @inversion_coefficient)*col + (@inversion_coefficient*(7 - col))
        render_position([transformed_row, transformed_col], selected_piece)
      end
      print "\n"
    end
    puts
  end

  def invert
    @inversion_coefficient = (@inversion_coefficient == 1 ? 0 : 1)
    @cursor.inv = -@cursor.inv
  end

  private

  def render_position(pos, selected_piece)
    piece = board[pos]
    b_color = select_background_color(pos, selected_piece)

    if selected_piece == piece
      print((board[pos].symbol + " ").colorize(color: piece.color, background: b_color).bold.blink)
    else
      print((board[pos].symbol + " ").colorize(color: piece.color, background: b_color).bold)
    end
  end

  def select_background_color(pos, selected_piece)
    if pos == cursor.cursor_pos
      b_color = :light_yellow
    elsif selected_piece && selected_piece.current_moves.include?(pos)
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
