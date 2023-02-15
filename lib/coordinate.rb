# This class represents a coordinate
# It will also translate from array coordinates to algebraic chess notation
class Coordinate
  attr_reader :row, :column

  ROWS = [*'1'..'8'].reverse.freeze
  COLUMNS = [*'a'..'h'].freeze
  ALL_COORDINATES = COLUMNS.product(ROWS).map(&:join).freeze

  # Holds vector like representations of directions
  Vector = Struct.new(:vertical, :lateral) do
    def self.for(direction)
      new(direction[0], direction[1])
    end
  end

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

  def initialize(**opts)
    row, column = Coordinate.to_array(opts[:algebraic]) if opts[:algebraic]

    @row = row || opts[:row]
    @column = column || opts[:column]
  end

  def algebraic
    COLUMNS[column] + ROWS[row]
  end

  def traverse(direction)
    direction = Vector.for(direction)

    Coordinate.new(row: row + direction.vertical,
                   column: column + direction.lateral)
  end

  def ==(other)
    self.class == other.class &&
      row == other.row && column == other.column
  end
end
