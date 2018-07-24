module Slideable
  def moves
    differentials = move_differentials
    poss_pos = []
    differentials.each do |diff|
      poss_pos += find_moves_in_direction(diff)
    end
    poss_pos
  end

  private

  def find_moves_in_direction(diff)
    pos_move = [self.pos[0] + diff[0], self.pos[1] + diff[1]]
    return [] unless valid_pos?(pos_move)

    potential_moves = [pos_move]
    return potential_moves if board[pos_move].color != self.color && board[pos_move] != NullPiece.instance

    loop_condition = true
    while loop_condition
      next_move = [potential_moves[-1][0] + diff[0], potential_moves[-1][1] + diff[1]]
      loop_condition = valid_pos?(next_move) ? (potential_moves << next_move) : (false)
    end
    potential_moves
  end

  def valid_pos?(pos_move)
    board.in_bounds?(pos_move) &&
    (board[pos_move].is_a?(NullPiece) || self.color != board[pos_move].color)
  end
end
