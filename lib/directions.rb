# This module will fetch columns rows or diagonals
module Directions
  include Coordinates

  def columns(board)
    board.board.transpose
  end

  def diagonals(board)
    main_diagonals(board).concat(anti_diagonals(board))
  end

  def main_diagonals(board)
    diagonals = []
    board.board.first.each_index do |column|
      diagonals << single_diagonal(board, 0, column)
    end

    columns(board).first.each_index do |row|
      diagonals << single_diagonal(board, row, 0)
    end
    diagonals.select { |diagonal| diagonal.size > 1 }
  end

  def anti_diagonals(board)
    main_diagonals(board.transpose.reverse)
  end

  def single_diagonal(board, row, column)
    diagonal = []
    while valid_position?(row, column)
      diagonal << board.board[row][column]
      row += 1
      column += 1
    end
    diagonal
  end

  def valid_position?(row, column)
    [row, column].all? { |el| el.between?(0, SIZE - 1) }
  end
end
