class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize (color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    self.symbol
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def valid_moves
    if !self.empty?
      
      valid_move_arr = []
      
      moves.each { |move| valid_move_arr << move if !move_into_check?(move) }      

      valid_move_arr
    end
  end

  private

  def move_into_check? (end_pos)
    dup_board = @board.dup

    dup_board.move_piece!(@color, @pos, end_pos)

    dup_board.in_check?(@color)
  end
end