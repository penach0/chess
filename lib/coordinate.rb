# This class represents a coordinate
# It will also translate from array coordinates to algebraic chess notation
class Coordinate
  attr_reader :row, :column

  TRANSLATORS = {
    algebraic_to_array: {
      row: ->(row) { (Board::SIZE - row.to_i) },
      column: ->(column) { column.ord - 97 }
    }
  }.freeze

  ROWS = [*'1'..'8'].reverse.freeze
  COLUMNS = [*'a'..'h'].freeze
  ALL_COORDINATES = COLUMNS.product(ROWS).map(&:join).freeze

  # Holds vector like representations of directions
  Vector = Struct.new(:vertical, :lateral) do
    def self.for(direction)
      new(direction[0], direction[1])
    end
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

  def self.from_string(string)
    new(row: TRANSLATORS[:algebraic_to_array][:row].call(string[1]),
        column: TRANSLATORS[:algebraic_to_array][:column].call(string[0]))
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
