require_relative "modules/stepable"
require_relative "piece"

class King < Piece
  include Stepable

  def initialize (color, board, pos)
    super
  end

  def symbol
    if color == :w
      return '♔'
    else
      return '♚'
    end
  end

  protected

  def move_diffs
    return [[0, -1], [0, 1], [-1, 0], [1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end