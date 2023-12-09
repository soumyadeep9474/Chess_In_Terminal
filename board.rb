require_relative "piece"
require_relative "bishop"
require_relative "king"
require_relative "knight"
require_relative "null_piece"
require_relative "pawn"
require_relative "queen"
require_relative "rook"

class Board
  def initialize (is_dup=false)
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }

    if !is_dup
      @grid.each_with_index do |row, i|
        if i.between?(0,1)
          symbol = :b
        elsif i.between?(6,7)
          symbol = :w
        end

        if i == 0 || i == 7
          @grid[i] = [Rook.new(symbol, self, [i, 0]), 
                      Knight.new(symbol, self, [i, 1]), 
                      Bishop.new(symbol, self, [i, 2]),
                      Queen.new(symbol, self, [i, 3]), 
                      King.new(symbol, self, [i, 4]),
                      Bishop.new(symbol, self, [i, 5]),
                      Knight.new(symbol, self, [i, 6]), 
                      Rook.new(symbol, self, [i, 7])]
        elsif i == 1 || i == 6
          (0...@grid.length).each { |j| @grid[i][j] = Pawn.new(symbol, self, [i, j]) }
        end
      end
    end
  end

  def [] (pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece (color, start_pos, end_pos)
    start_piece = self[start_pos]
    end_piece = self[end_pos]

    if start_piece.empty?
      raise "No piece at #{start_pos}!"
    elsif start_piece.color != color
      raise "Cannot move other player's piece!"
    elsif !end_piece.empty? && end_piece.color == color
      raise "Cannot move to #{end_pos}: Occupied by same-colored piece."
    elsif !start_piece.valid_moves.include?(end_pos)
      raise "Invalid move!"
    end

    add_piece(start_piece, end_pos)
    self[start_pos] = NullPiece.instance
  end

  def valid_pos? (pos)
    row, col = pos

    if !row.between?(0,7) || !col.between?(0,7)
      return false
    else
      return true
    end
  end

  def add_piece (piece, pos)
    self[pos] = piece
    piece.pos = pos
  end

  def find_king (color)
    pieces.each do |piece|
      if piece.is_a?(King) && piece.color == color
        return piece.pos
      end
    end
  end

  def in_check? (color)
    king_pos = find_king(color)

    pieces.each do |piece|
      moves = piece.moves
      if piece.color != color && moves.include?(king_pos)
        return true
      end
    end

    return false
  end

  def checkmate? (color)
    if in_check?(color)
      pieces.each do |piece|
        valid_moves = piece.valid_moves
        if piece.color == color && valid_moves.length > 0
          return false
        end
      end
    else
      return false
    end

    return true
  end

  def pieces
    piece_arr = []

    @grid.each do |row|
      row.each { |piece| piece_arr << piece if !piece.empty? }
    end

    piece_arr
  end

  def dup
    dup_board = Board.new(true)

    pieces.each do |piece|
      class_type = piece.class
      dup_pos = [piece.pos[0], piece.pos[1]]
      new_piece = class_type.new(piece.color, dup_board, dup_pos)
      dup_board.add_piece(new_piece, dup_pos)
    end

    dup_board
  end

  def move_piece! (color, start_pos, end_pos)    
    start_piece = self[start_pos]
    end_piece = self[end_pos]

    if start_piece.empty?
      raise "No piece at #{start_pos}!" 
    elsif !end_piece.empty? && end_piece.color == color
      raise "Cannot move to #{end_pos}. Occupied by same-colored piece."
    end

    add_piece(start_piece, end_pos)
    self[start_pos] = NullPiece.instance
  end
end