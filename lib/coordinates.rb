# This module holds information related to coordinates
# It will translate from algebraic array coordinates to chess notation
module Coordinates
  ROWS = [*'1'..'8'].reverse.freeze
  COLUMNS = [*'a'..'h'].freeze
  ALL_COORDINATES = COLUMNS.product(ROWS).map(&:join).freeze
  SIZE = 8

  def valid_coordinate?(coordinate)
    ALL_COORDINATES.include?(coordinate)
  end

  def square_to_coordinates(squares)
    squares.map { |square| square.coordinate }
  end

  def array_to_algebraic(row, column)
    COLUMNS[column] + ROWS[row]
  end

  # Probably won't be needed - Delete when sure
  def algebraic_to_array(coordinate)
    column = COLUMNS.find_index(coordinate[0])
    row = ROWS.find_index(coordinate[1])

    [row, column]
  end
end
