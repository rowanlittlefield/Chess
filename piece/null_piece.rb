require 'singleton'
require_relative "piece"

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :dummy
  end

  def symbol
    " "
  end
end
