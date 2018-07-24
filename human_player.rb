class HumanPlayer
  attr_reader :color, :cursor
  attr_accessor :selected_piece
  def initialize(display, color)
    @display = display
    @color = color
    @selected_piece = nil
  end

  def action
    @display.render(@selected_piece)
    print "Current player #{color.to_s}"
    @display.cursor.get_input
  end
end
