require_relative "modules/slideable"
require_relative "piece"

class Bishop < Piece
  include Slideable

  def initialize (color, board, pos)
    super
  end

  def symbol
    if color == :w
      return '♗'
    else
      return '♝'
    end
  end

  private
  def move_dirs
    diagonal_dirs
  end
end