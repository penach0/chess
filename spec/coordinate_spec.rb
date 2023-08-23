require_relative '../lib/chess'

describe Coordinate do
  describe '.from_string' do
    it 'initializes a coordinate object from a algebraic notation string' do
      algebraic_coordinate = 'a8'
      coordinate = described_class.from_string(algebraic_coordinate)

      expect(coordinate).to eq(Coordinate.new(row: 0, column: 0))
    end
  end
end