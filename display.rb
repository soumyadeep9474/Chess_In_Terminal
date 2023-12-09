require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  attr_reader :cursor

  def initialize (board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system("clear")
    print "\n"
    # (0..7).each { |col| print "  #{col}" }

    (0..7).each do |row|
      print "\n|"
      (0..7).each do |col|
        render_pos(row, col)
      end
    end

    print "\nCHECK" if @board.in_check?(:w) || @board.in_check?(:b)
    print "\n"
  end

  private

  def render_pos(row, col)
    piece = @board[[row, col]]
    symbol = piece.to_s

    print " "
    if [row, col] == @cursor.cursor_pos
      if @cursor.selected
        print "#{symbol} ".colorize(:background => :red)
      else
        print "#{symbol} ".colorize(:background => :blue)
      end
    else        
      print "#{symbol} "
    end
  end
end