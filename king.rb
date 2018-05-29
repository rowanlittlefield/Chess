require_relative 'piece'
require_relative 'stepping_piece'


class King < Piece
  include Stepable

  def symbol
    "K"
  end

  protected

  def move_diffs
      [[-1,-1],[1,-1], [1,1], [-1,1],[-1,0],[1,0], [0,1], [0,-1]]
  end
end
