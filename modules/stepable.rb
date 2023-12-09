module Stepable
  def moves
    move_arr = []

    move_diffs.each do |move|
      dx = pos[0] + move[0]
      dy = pos[1] + move[1]
      next_move = [dx, dy]

      if @board.valid_pos?(next_move)
        piece = @board[next_move]
        if !piece.empty?
          if piece.color != self.color
            move_arr << next_move
          end
        else
          move_arr << next_move
        end
      end
    end

    move_arr
  end

  private

  def move_diffs
  end
end