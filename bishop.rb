require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include Slideable

  def symbol
    "B"
  end

  protected

  def move_dirs
    pos_moves = [[-1,-1],[1,-1], [1,1], [-1,1]]
  end
end
