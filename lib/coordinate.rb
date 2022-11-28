# This class represents a coordinate
# It will also translate from array coordinates to algebraic chess notation
class Coordinate
  attr_reader :row, :column, :algebraic

  ROWS = [*'1'..'8'].reverse.freeze
  COLUMNS = [*'a'..'h'].freeze
  ALL_COORDINATES = COLUMNS.product(ROWS).map(&:join).freeze

  def self.square_to_coordinates(squares)
    squares.map(&:algebraic)
  end

  def self.to_algebraic(row, column)
    COLUMNS[column] + ROWS[row]
  end

  def self.to_array(coordinate)
    return [coordinate.row, coordinate.column] if coordinate.is_a?(Coordinate)

    column = COLUMNS.find_index(coordinate[0])
    row = ROWS.find_index(coordinate[1])

    [row, column]
  end

  def self.valid?(coordinate)
    ALL_COORDINATES.include?(coordinate)
  end

  def initialize(row, column)
    @row = row
    @column = column
    @algebraic = Coordinate.to_algebraic(row, column)
  end
end
