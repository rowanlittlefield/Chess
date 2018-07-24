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
    loop_is_over = false
    until loop_is_over
      move = @current_player.make_move
      if move.is_a?(Array) && @current_player.color == @board[move].color
        select_piece(move)
        loop_is_over = move_piece_loop(move)
      end
    end
  end

  def select_piece(move)
    piece = @board[move]
    piece.moves = piece.valid_moves
    @current_player.selected_piece = piece
  end

  def move_piece_loop(move)
    piece = @current_player.selected_piece
    loop_over = false
    until loop_over
      player_action = @current_player.make_move
      if player_action.is_a?(Array) && piece.valid_moves.include?(player_action)
        @board.move_piece(move,player_action)
        loop_over = true
        deselect_piece
        switch_players
        return true
      elsif player_action == :back
        deselect_piece
        loop_over = true
        return false
      end
    end

  end

  def deselect_piece
    @current_player.selected_piece.moves = []
    @current_player.selected_piece = nil
  end

  def switch_players
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
