require_relative '../piece'
require_relative 'stepping_piece'


class King < Piece
  include Stepable

  def symbol
    "\u2654"
  end

  def castling_moves
    return [] if self.has_moved #|| board.in_check?(self.color)

    possible_rook_positions = self.color == :white ? [[7, 0], [7,7]] : [[0,0], [0, 7]]
      castle_moves = []
    if self.color == :white
      if (board[[7, 7]].is_a?(Rook) && board[[7, 7]].color == self.color && !board[[7, 7]].has_moved &&
        board[[7, 6]].is_a?(NullPiece) && board[[7, 5]].is_a?(NullPiece))
        castle_moves << [7, 6] #unless board.in_check?(self.color)
      end
      if (board[[7, 0]].is_a?(Rook) && board[[7, 0]].color == self.color && !board[[7, 0]].has_moved &&
        board[[7, 1]].is_a?(NullPiece) && board[[7, 2]].is_a?(NullPiece) && board[[7, 3]].is_a?(NullPiece))
        castle_moves << [7, 2] #unless board.in_check?(self.color)
      end

    elsif self.color == :black
      if (board[[0, 7]].is_a?(Rook) && board[[0, 7]].color == self.color && !board[[0, 7]].has_moved &&
        board[[0, 6]].is_a?(NullPiece) && board[[0, 5]].is_a?(NullPiece))
        castle_moves << [0, 6] #unless board.in_check?(self.color)
      end
      if (board[[0, 0]].is_a?(Rook) && board[[0, 0]].color == self.color && !board[[0, 0]].has_moved &&
        board[[0, 1]].is_a?(NullPiece) && board[[0, 2]].is_a?(NullPiece) && board[[0, 3]].is_a?(NullPiece))
        castle_moves << [0, 2] #unless board.in_check?(self.color)
      end
    end
    castle_moves
  end

  protected

  def move_differentials
      [[-1,-1],[1,-1], [1,1], [-1,1],[-1,0],[1,0], [0,1], [0,-1]]
  end
end
