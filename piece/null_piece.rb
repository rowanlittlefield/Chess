require 'singleton'
require_relative "piece"

class NullPiece < Piece
  include Singleton
  
  def initialize
    @color = :green
  end
  
  def moves
    
  end
  
  def symbol
    " "
  end
end