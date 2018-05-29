require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include Stepable

  def symbol
    "k"
  end

  protected

  def move_diffs
    [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2]]
  end
end
