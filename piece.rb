class Piece
  attr_reader :color, :board, :pos
  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
  end

  def empty?

  end

  def valid_moves
    the_moves = moves
    output = the_moves.reject do |move|
      # byebug if move == [5,4]
       move_into_check?(move)
    end
    output
  end

  def pos=(val)
    @pos = val
  end

  def symbol

  end

  def deep_dup(dupped_board)
    self.class.new(color, dupped_board, pos.dup)
  end

  private
  def move_into_check?(end_pos)
    # byebug if end_pos == [6,4]
    board_dup = board.dup
    board_dup.move_piece(pos, end_pos)
    board_dup.in_check?(color)
  end
end
