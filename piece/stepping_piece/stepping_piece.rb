require 'byebug'

module Stepable
  def moves
    poss_pos = []
    move_differentials.each do |diff|
      pos_move = [self.pos[0] + diff[0], self.pos[1] + diff[1]]
      poss_pos << pos_move if valid_pos?(pos_move)
    end

    if self.is_a?(King)
      poss_pos += castling_moves
    end

    poss_pos
  end

  private

  def valid_pos?(pos_move)
    board.in_bounds?(pos_move) &&
    (board[pos_move].is_a?(NullPiece) || self.color != board[pos_move].color)
  end
end
