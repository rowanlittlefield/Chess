require "byebug"
require 'colorize'
require_relative "piece_types"

class Board
  attr_reader :grid
  
  def initialize(grid = nil)
    grid ||= setup_grid
    @grid = grid
  end

  def setup_grid
    new_grid = Array.new(8) { Array.new(8) }
    
    (new_grid[2..5]).each do |row|
      (0...8).each do |c|
        row[c] = NullPiece.instance
      end
    end
    # set pawns
    (0...8).each do |i|
      new_grid[1][i] = Pawn.new(:black,self,[1,i])
    end
    (0...8).each do |i|
      new_grid[6][i] = Pawn.new(:white,self,[6,i])
    end
    
    # set rooks
    new_grid[0][0] = Rook.new(:black, self, [0,0])
    new_grid[0][7] = Rook.new(:black, self, [0,7])
    new_grid[7][0] = Rook.new(:white, self, [7,0])
    new_grid[7][7] = Rook.new(:white, self, [7,7])
    
    #set knights
    new_grid[0][1] = Knight.new(:black, self, [0,1])
    new_grid[0][6] = Knight.new(:black, self, [0,6])
    new_grid[7][1] = Knight.new(:white, self, [7,1])
    new_grid[7][6] = Knight.new(:white, self, [7,6])
      
    # set bishops
    new_grid[0][2] = Bishop.new(:black, self, [0,2])
    new_grid[0][5] = Bishop.new(:black, self, [0,5])
    new_grid[7][2] = Bishop.new(:white, self, [7,2])
    new_grid[7][5] = Bishop.new(:white, self, [7,5])
    
    # set kings
    new_grid[0][4] = King.new(:black, self, [0,4])
    new_grid[7][4] = King.new(:white, self, [7,4])
    
    # set queens
    new_grid[0][3] = Queen.new(:black, self, [0,3])
    new_grid[7][3] = Queen.new(:white, self, [7,3])
    

    new_grid
  end
  
  def render
    (0...grid.length).each do |i|
      (0...grid[i].length).each do |j|
        piece = self[[i, j]]
        p_color = piece.color
        b_color = (i.even? ? even_pattern(j) : odd_pattern(j))
        print self[[i, j]].symbol.colorize(color: p_color, background: b_color)
      end
      print "\n"
    end
  end
  
  def even_pattern(col_num)
    col_num.even? ? :red : :cyan
  end
  
  def odd_pattern(col_num)
    col_num.odd? ? :red : :cyan
  end
  
  
  def [](pos)
    row,col = pos
    grid[row][col]
  end
  
  def []=(pos,val)
    row,col = pos
    grid[row][col] = val
  end
  
  def move_piece(start_pos, end_pos)
    raise "invalid move" if self[start_pos].is_a?(NullPiece) || !(in_bounds?(end_pos))
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
    piece.pos = end_pos
  end
  
  def in_bounds?(pos)
    row,col = pos
    (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
  end
  
  
end
  board = Board.new
  board.move_piece([1,0],[3,0])
  # board.move_piece([5,0],[3,0])
  board.render
  