require_relative '../piece'
require_relative 'stepping_piece'

class Knight < Piece
  include Stepable

  def symbol
    "\u2658"
  end

  protected

  def move_differentials
    [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2]]
  end
end
