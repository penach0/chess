# This module will handle the translation of FEN strings
# into full Board objects and vice-versa
module FENTranslator
  def fen_to_board(fen_string)

  end

  def split_fen(fen_string)
    fen_string.split('/').map { |line| line.split('') }
  end
end
