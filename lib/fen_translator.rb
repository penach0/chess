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
end
