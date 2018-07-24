require 'byebug'
class Piece
  attr_reader :color, :board
  attr_accessor :current_moves, :pos
  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
    @current_moves = []
  end

  def valid_moves
    output = moves.reject do |move|
       move_into_check?(move)
    end
    output
  end

  def symbol
    ''
  end

  def deep_dup(dupped_board)
    self.class.new(color, dupped_board, pos.dup)
  end

  private
  def move_into_check?(end_pos)
    board_dup = board.dup
    board_dup.move_piece(pos, end_pos)
    board_dup.in_check?(color)
  end

end
