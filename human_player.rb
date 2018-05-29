require_relative "cursor"

class HumanPlayer
  attr_reader :color, :cursor
  def initialize(display, color)
    @display = display
    @color = color
  end

  def make_move
    @display.render
    print color.to_s
    @display.cursor.get_input
  end
end
