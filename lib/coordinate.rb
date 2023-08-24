# This class represents a coordinate
# It will also translate from array coordinates to algebraic chess notation
class Coordinate
  attr_reader :row, :column

  TRANSLATORS = {
    algebraic_to_array: {
      row: ->(row, board_size = 8) { (board_size - row.to_i) },
      column: ->(column) { column.ord - 97 }
    },
    array_to_algebraic: {
      row: ->(row, board_size = 8) { (board_size - row).to_s },
      column: ->(column) { (column + 97).chr }
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

  def self.valid?(coordinate)
    ALL_COORDINATES.include?(coordinate)
  end

  def self.from_string(string, board_size: 8)
    new(row: TRANSLATORS[:algebraic_to_array][:row].call(string[1], board_size),
        column: TRANSLATORS[:algebraic_to_array][:column].call(string[0]))
  end

  def initialize(row:, column:)
    @row = row
    @column = column
  end

  def to_s(board_size: 8)
    TRANSLATORS[:array_to_algebraic][:column].call(column) +
      TRANSLATORS[:array_to_algebraic][:row].call(row, board_size)
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
