# This module will handle the translation of FEN strings
# into full Board objects and vice-versa
module FENTranslator
  def fen_info(fen_value, info)
    {
      'K' => { symbol: ' ♔ ', color: 'white' }, 'k' => { symbol: ' ♚ ', color: 'black' },
      'Q' => { symbol: ' ♕ ', color: 'white' }, 'r' => { symbol: ' ♜ ', color: 'black' },
      'R' => { symbol: ' ♖ ', color: 'white' }, 'n' => { symbol: ' ♞ ', color: 'black' },
      'B' => { symbol: ' ♗ ', color: 'white' }, 'q' => { symbol: ' ♛ ', color: 'black' },
      'N' => { symbol: ' ♘ ', color: 'white' }, 'b' => { symbol: ' ♝ ', color: 'black' },
      'P' => { symbol: ' ♙ ', color: 'white' }, 'p' => { symbol: ' ♟︎ ', color: 'black' },
      ' ' => { symbol: '   ', color: nil }
    }[fen_value][info]
  end
end
