require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include Slideable

  def symbol
    "Q"
  end

  protected

  def move_dirs
    pos_moves = [[-1,-1],[1,-1], [1,1], [-1,1],[-1,0],[1,0], [0,1], [0,-1]]


  end
end
