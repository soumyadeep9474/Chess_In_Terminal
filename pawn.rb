require_relative "piece"

class Pawn < Piece
  def initialize (color, board, pos)
    super
  end

  def symbol
    if color == :w
      return '♙'
    else
      return '♟︎'
    end
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    if (@color == :w && @pos[0] == 6) || (@color == :b && @pos[0] == 1)
      return true
    else
      return false
    end
  end

  def forward_dir
    if @color == :w
      return -1
    else
      return 1
    end
  end

  def forward_steps
    steps = []

    new_row = pos[0] + forward_dir
    new_pos = [new_row, pos[1]]

    if !blocked?(new_pos)
      steps << new_pos

      if at_start_row?
        new_row += forward_dir
        new_pos = [new_row, pos[1]]
        steps << new_pos if !blocked?(new_pos)
      end
    end

    steps
  end

  def blocked? (end_pos)
    !@board[end_pos].empty?
  end

  def side_attacks
    attack_arr = []
    
    diag_1 = [@pos[0] + forward_dir, pos[1] - 1]
    diag_2 = [@pos[0] + forward_dir, pos[1] + 1]

    attack_arr << diag_1 if can_attack?(diag_1)
    attack_arr << diag_2 if can_attack?(diag_2)
       
    attack_arr
  end

  def can_attack? (pos)
    if board.valid_pos?(pos)
      piece = @board[pos]
      if !piece.empty? && piece.color != self.color
        return true
      end
    end

    return false
  end
end