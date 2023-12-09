require "singleton"
require_relative "piece"

class NullPiece < Piece
  include Singleton

  attr_reader :color

  def initialize
  end

  def moves
  end

  def symbol
    return " "
  end
end