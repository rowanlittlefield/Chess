require_relative "player"
require_relative "display/display"
require_relative "display/board"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = [
      Player.new(display, :white),
      Player.new(display, :black)
    ]
  end

  def play
    play_turn until board.checkmate(current_player.color)
    game_over_message
  end

  private

  attr_reader :board, :display, :players

  def play_turn
    loop_is_over = false
    until loop_is_over || board.checkmate(current_player.color) || board.checkmate(@players[1].color)
      move = current_player.action
      if move.is_a?(Array) && current_player.color == board[move].color
        select_piece(move)
        loop_is_over = move_piece_loop(move)
      end
    end
  end

  def select_piece(move)
    piece = board[move]
    piece.current_moves = piece.valid_moves
    current_player.selected_piece = piece
  end

  def move_piece_loop(move)
    piece = current_player.selected_piece
    while true
      player_action = current_player.action
      if player_action.is_a?(Array) && piece.current_moves.include?(player_action)
        end_turn(move, player_action)
        return true
      elsif player_action == :back
        deselect_piece
        return false
      end
    end
  end

  def end_turn(move, player_action)
    board.move_piece(move, player_action)
    deselect_piece
    switch_players
    display.invert
  end

  def deselect_piece
    current_player.selected_piece.current_moves = []
    current_player.selected_piece = nil
  end

  def switch_players
    current_player.last_position = display.cursor.cursor_pos.dup
    players.rotate!
    display.cursor.cursor_pos = current_player.last_position.dup
  end

  def current_player
    players[0]
  end

  def game_over_message
    switch_players
    display.render(board[current_player.last_position])
    puts "#{current_player.color} wins!!"
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
