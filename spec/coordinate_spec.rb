require_relative '../lib/chess'

describe Coordinate do
  describe '.from_string' do
    it 'initializes a coordinate object from an algebraic notation string' do
      algebraic_string = 'a8'
      coordinate = described_class.from_string(algebraic_string)

      expect(coordinate).to eq(Coordinate.new(row: 0, column: 0))
    end

    it 'initializes a coordinate from a different string' do
      algebraic_string = 'c4'
      coordinate = described_class.from_string(algebraic_string)

      expect(coordinate).to eq(Coordinate.new(row: 4, column: 2))
    end
  end
end