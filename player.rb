class Player
  attr_reader :color, :cursor
  attr_accessor :selected_piece, :last_position
  def initialize(display, color)
    @display = display
    @color = color
    @selected_piece = nil
    @last_position = color == :white ? [7, 4] : [0, 4]
  end

  def action
    @display.render(@selected_piece)
    print "Current player #{color.to_s}"
    @display.cursor.get_input
  end
end
