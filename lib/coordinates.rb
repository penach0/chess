# This module holds information related to coordinates
# It will translate from algebraic array coordinates to chess notation
module Coordinates
  ROWS = [*'1'..'8'].reverse.freeze
  COLUMNS = [*'a'..'h'].freeze

  def array_to_algebraic(row, column)
    COLUMNS[column] + ROWS[row]
  end
end
