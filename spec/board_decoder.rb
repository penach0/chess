# This module decodes a board object into a FEN string
module BoardDecoder
  def fen_string(board)
    board_string = board_to_string(board)
    join_spaces(board_string)
  end

  def board_to_string(board)
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
