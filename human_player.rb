class HumanPlayer < Player
  def make_move (board)
    cursor = @display.cursor

    while !cursor.selected
      start_pos = cursor.get_input
      @display.render
    end

    while cursor.selected
      end_pos = cursor.get_input
      @display.render
    end 

    [start_pos, end_pos]
  end
end