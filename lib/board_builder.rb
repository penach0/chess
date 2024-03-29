# This class is responsible for building a board object from a FEN string
class BoardBuilder
  attr_reader :fen_string

  def self.build(string)
    new(string).build_board
  end

  def initialize(string)
    @fen_string = string
  end

  def build_board
    fen_to_array.map.with_index do |line, row_index|
      squarify_line(line, row_index)
    end
  end

  private

  def squarify_line(line, row_index)
    line.map.with_index do |fen, col_index|
      Square.new(row_index, col_index, fen)
    end
  end

  def fen_to_array
    fen_lines = split_fen
    build_array(fen_lines)
  end

  def split_fen
    fen_string.split('/').map { |line| line.split('') }
  end

  def build_array(fen_lines)
    fen_lines.map do |line|
      build_line(line)
    end
  end

  def build_line(line)
    line.map do |char|
      number = char.to_i
      number.zero? ? char : spread_empty_spaces(number)
    end.flatten
  end

  def spread_empty_spaces(number)
    Array.new(number.to_i, ' ')
  end
end
