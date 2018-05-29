require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece
  include Slideable

  def symbol
    "R"
  end

  protected

  def move_dirs
    pos_moves = [[-1,0],[1,0], [0,1], [0,-1]]
  end
end
