# This module decodes a board object into a FEN string
module BoardDecoder
  def board_fen_string(board)
    board_string = array_to_string(board)
    join_spaces(board_string)
  end

  private

  def array_to_string(board)
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
