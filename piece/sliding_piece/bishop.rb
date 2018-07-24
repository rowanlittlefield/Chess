require_relative '../piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include Slideable

  def symbol
    "\u2657"
  end

  protected

  def move_differentials
    pos_moves = [[-1,-1],[1,-1], [1,1], [-1,1]]
  end
end
