module Slideable
  HORIZONTAL_DIRS = [[-1, 0],[1, 0],[0, -1],[0, 1]]
  DIAGONAL_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  private_constant :HORIZONTAL_DIRS, :DIAGONAL_DIRS

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    move_arr = []
    move_dirs.each { |dir| move_arr += grow_unblocked_moves_in_dir(*dir) }
    move_arr
  end

  private

  def move_dirs
  end

  def grow_unblocked_moves_in_dir (dx, dy)
    move_arr = []
    next_dx = dx + @pos[0]
    next_dy = dy + @pos[1]
    finished = false

    while !finished
      next_move = [next_dx, next_dy]

      if @board.valid_pos?(next_move)
        piece = @board[next_move]
        if !piece.empty?
          if piece.color != self.color
            move_arr << next_move
          end
          finished = true
        else
          move_arr << next_move
        end
      else
        finished = true
      end

      next_dx += dx
      next_dy += dy
    end

    move_arr
  end
end