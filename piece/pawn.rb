require_relative 'piece'

class Pawn < Piece

  def symbol
    "\u2659"
  end

  def moves
    moves = []

    forward_steps.each do |step|
      if board.in_bounds?(step) && board[step] == NullPiece.instance
        moves << step
      else
        break
      end
    end

    side_attacks.each do |step|
      if (board.in_bounds?(step) && board[step] != NullPiece.instance &&
         board[step].color != color)
        moves << step
      end
    end

    moves
  end

  private

  def at_start_row?
    (color == :black && pos[0] == 1) || (color == :white && pos[0] == 6)
  end

  def forward_dir
    color == :black ? +1 : -1
  end

  def forward_steps
    if at_start_row?
      [[pos[0] + forward_dir, pos[1]], [pos[0] + (2*forward_dir), pos[1]]]
    else
      [[pos[0] + forward_dir, pos[1]]]
    end
  end

  def side_attacks
    [[pos[0] + forward_dir, pos[1] + 1], [pos[0] + forward_dir, pos[1] - 1]]
  end

end
