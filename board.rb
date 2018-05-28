require_relative "piece"
require_relative "null_piece"

class Board
  def self.setup_grid
    grid = Array.new(8) { Array.new(8) }
    
    (grid[2..5]).each do |row|
      (0...8).each do |c|
        row[c] = NullPiece.instance
      end
    end
    
    grid
  end
  
  def initialize(grid = nil)
    grid ||= Board.setup_grid
    @grid = grid
  end
end

p Board.setup_grid