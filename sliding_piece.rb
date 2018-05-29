module Slideable
  def moves
    dirs = move_dirs
    poss_pos = []
    dirs.each do |dir|
      pos_move = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
      if valid_pos?(pos_move)
        poss_pos << pos_move
        next if board[pos_move].color != self.color && board[pos_move] != NullPiece.instance
      else
        next
      end
      next_move = [pos_move[0] + dir[0], pos_move[1] + dir[1]]
      while valid_pos?(next_move)
        poss_pos << next_move if valid_pos?(next_move)
        break if !(board.in_bounds?(pos_move)) || board[next_move] != NullPiece.instance
        next_move = [next_move[0] + dir[0], next_move[1] + dir[1]]
      end
    end
    poss_pos.sort
  end

  private

  def valid_pos?(pos_move)
    board.in_bounds?(pos_move) &&
    (board[pos_move].is_a?(NullPiece) || self.color != board[pos_move].color)
  end
end
