require_relative "modules/stepable"
require_relative "piece"

class Knight < Piece
  include Stepable

  def initialize (color, board, pos)
    super
  end

  def symbol
    if color == :w
      return '♘'
    else
      return '♞'
    end
  end

  protected

  def move_diffs
    return [[-2, -1], [-2, 1], [2, -1], [2, 1], [-1, -2], [1, -2], [-1, 2], [1, 2]]
  end
end