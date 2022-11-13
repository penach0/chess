require_relative 'coordinates'
# This module will fetch columns rows or diagonals
module Directions
  include Coordinates

  def find_paths(position, direction)
    direction.select { |path| check_path(path, position) }
  end

  private

  def check_path(path, position)
    square_to_coordinates(path).include?(position)
  end

  def columns(board)
    board.transpose
  end

  def diagonals(board)
    main_diagonals(board) + anti_diagonals(board)
  end

  def anti_diagonals(board)
    main_diagonals(board.transpose.reverse)
  end

  def main_diagonals(board)
    diagonals = diagonals_from_top(board) + diagonals_from_side(board)
    diagonals.select { |diagonal| diagonal.size > 1 }
  end

  def diagonals_from_top(board)
    diagonals = []
    board.first.each_index do |column|
      diagonals << single_diagonal(board, 0, column)
    end
    diagonals
  end

  def diagonals_from_side(board)
    diagonals = []
    columns(board).first.each_index do |row|
      next if row.zero?

      diagonals << single_diagonal(board, row, 0)
    end
    diagonals
  end

  def single_diagonal(board, row, column)
    diagonal = []
    while valid_position?(row, column)
      diagonal << board[row][column]
      row += 1
      column += 1
    end
    diagonal
  end

  def valid_position?(row, column)
    [row, column].all? { |el| el.between?(0, SIZE - 1) }
  end
end
