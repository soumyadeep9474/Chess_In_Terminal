require_relative "display"
require_relative "player"
require_relative "human_player"
require_relative "board"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)

    @white = HumanPlayer.new(:w, @display)
    @black = HumanPlayer.new(:b, @display)
    @current_player = @white
  end

  def play
    while !@board.checkmate?(:w) && !@board.checkmate?(:b)
      begin
        @display.render
        notify_players
        start_pos, end_pos = @current_player.make_move(@board)
        @board.move_piece(@current_player.color, start_pos, end_pos)
      rescue
        retry
      end

      swap_turn!
    end

    end_game
  end

  def end_game
    @display.render
    print "\nCheckmate."
  end

  private

  def notify_players
    print "\nEnter a valid move using the cursor keys."
  end

  def swap_turn!
    @current_player = @current_player == @white ? @black : @white 
  end
end

g = Game.new
g.play