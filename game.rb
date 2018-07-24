require_relative "human_player"
require_relative "display"
require_relative "board"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(@display, :white)
    @player2 = HumanPlayer.new(@display, :black)
    @current_player = @player1
  end

  def play
    play_turn until @board.checkmate(@current_player.color)
  end

  private

  def play_turn
    move = @current_player.make_move
    if move.is_a?(Array) && @current_player.color == @board[move].color
      piece = @board[move]
      piece.moves = piece.valid_moves
      @current_player.selected_piece = piece
      completed_turn = false
      until completed_turn
        end_pos = @current_player.make_move
        if end_pos.is_a?(Array) && piece.valid_moves.include?(end_pos)
          @board.move_piece(move,end_pos)
          completed_turn = true
          switch_players
        end
      end
    end
  end

  def switch_players
    @current_player.selected_piece.moves = []
    @current_player.selected_piece = nil
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
