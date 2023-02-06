# This class decodes a board object into a FEN string
class BoardDecoder
  attr_reader :board

  def self.decode(board)
    new(board).to_fen
  end

  def initialize(board)
    @board = board
  end

  def to_fen
    board_string = array_to_string
    join_spaces(board_string)
  end

  private

  def array_to_string
    board.map do |line|
      line_to_string(line)
    end.join('/')
  end

  def line_to_string(line)
    line.map do |square|
      square.piece.fen_value
    end.join
  end

  def join_spaces(string)
    string.gsub(/\s+/) { |spaces| spaces.size.to_s }
  end
end
