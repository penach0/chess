# This module will handle the translation of FEN strings
# into full Board objects and vice-versa
module FENTranslator
  FEN_TO_SYMBOL = {
    'K' => ' ♔ ', 'Q' => ' ♕ ',
    'R' => ' ♖ ', 'B' => ' ♗ ',
    'N' => ' ♘ ', 'P' => ' ♙ ',
    'k' => ' ♚ ', 'q' => ' ♛ ',
    'r' => ' ♜ ', 'b' => ' ♝ ',
    'n' => ' ♞ ', 'p' => ' ♟︎ ',
    ' ' => '   '
  }.freeze

  def fen_to_array(fen_string)
    board = split_fen(fen_string)
    build_board(board)
  end

  private

  def split_fen(fen_string)
    fen_string.split('/').map { |line| line.split('') }
  end

  def build_board(board)
    board.map do |line|
      build_line(line)
    end
  end

  def build_line(line)
    line.map do |char|
      number = char.to_i
      number.zero? ? char : spread_empty_spaces(number)
    end.flatten
  end

  def spread_empty_spaces(number)
    Array.new(number.to_i, ' ')
  end
end
