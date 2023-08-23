require_relative '../lib/chess'

describe Coordinate do
  describe '.from_string' do
    it 'initializes a coordinate object from an algebraic notation string' do
      algebraic_string = 'a8'
      coordinate = described_class.from_string(algebraic_string)

      expect(coordinate).to eq(described_class.new(row: 0, column: 0))
    end

    it 'initializes a coordinate from a different string' do
      algebraic_string = 'c4'
      coordinate = described_class.from_string(algebraic_string)

      expect(coordinate).to eq(described_class.new(row: 4, column: 2))
    end

    it 'can initialize coordinates for boards larger than 8x8' do
      Board::SIZE = 10
      algebraic_string = 'j9'
      coordinate = described_class.from_string(algebraic_string)

      expect(coordinate).to eq(described_class.new(row: 1, column: 9))
    end
  end

  describe '#to_s' do
    it 'returns a string with the coresponding algebraic notation' do
      coordinate = described_class.new(row: 0, column: 0)
      algebraic_string = coordinate.to_algebraic

      expect(algebraic_string).to eq('a8')
    end

    it 'works with a different coordinate' do
      coordinate = described_class.new(row: 4, column: 2)
      algebraic_string = coordinate.to_algebraic

      expect(algebraic_string).to eq('c4')
    end

    it 'works with coordinates for boards larger than 8x8' do
      Board::SIZE = 10
      coordinate = described_class.new(row: 1, column: 9)
      algebraic_string = coordinate.to_algebraic

      expect(algebraic_string).to eq('j9')
    end
  end
end
