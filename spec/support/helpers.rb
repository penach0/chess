# This module holds helper methods to share between spec files
module Helpers
  WHITE_PIECE_FEN = 'B'.freeze
  BLACK_PIECE_FEN = 'b'.freeze
  NO_PIECE_FEN = ' '.freeze

  def algebraic_from_squares(squares)
    squares.map(&:algebraic)
  end
end
