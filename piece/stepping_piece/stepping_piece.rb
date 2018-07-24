module Stepable
  def moves
    diffs = move_diffs
    poss_pos = []
    diffs.each do |diff|
      pos_move = [self.pos[0] + diff[0], self.pos[1] + diff[1]]
      poss_pos << pos_move if valid_pos?(pos_move)
    end

    poss_pos.sort
  end

  private

  def valid_pos?(pos_move)
    board.in_bounds?(pos_move) &&
    (board[pos_move].is_a?(NullPiece) || self.color != board[pos_move].color)
  end
end