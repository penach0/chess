require_relative 'coordinates'
# This module will fetch columns rows or diagonals
module Directions
  include Coordinates

  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
                  [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def find_paths(position, direction)
    direction.select { |path| check_path(path, position) }
  end

  private

  def check_path(path, position)
    square_to_coordinates(path).include?(position)
  end

  def all_directions(board)
    straight_lines(board) + diagonals(board)
  end

  def straight_lines(board)
    lines(board) + columns(board)
  end

  def lines(board)
    board
  end

  def columns(board)
    board.transpose
  end

  def l_shape(position, board)
    coordinate = algebraic_to_array(position)
    possible_squares = []

    KNIGHT_MOVES.each do |direction|
      row, column = knight_jump(coordinate, direction)
      possible_squares << board[row][column] if valid_position?(row, column)
    end

    possible_squares
  end

  def knight_jump(coordinate, direction)
    row = coordinate[0] + direction[0]
    column = coordinate[1] + direction[1]

    [row, column]
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
