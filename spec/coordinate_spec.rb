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
      algebraic_string = 'j9'
      coordinate = described_class.from_string(algebraic_string, board_size: 10)

      expect(coordinate).to eq(described_class.new(row: 1, column: 9))
    end
  end

  describe '#to_s' do
    it 'returns a string with the coresponding algebraic notation' do
      coordinate = described_class.new(row: 0, column: 0)
      algebraic_string = coordinate.to_s

      expect(algebraic_string).to eq('a8')
    end

    it 'works with a different coordinate' do
      coordinate = described_class.new(row: 4, column: 2)
      algebraic_string = coordinate.to_s

      expect(algebraic_string).to eq('c4')
    end

    it 'works with coordinates for boards larger than 8x8' do
      coordinate = described_class.new(row: 1, column: 9)
      algebraic_string = coordinate.to_s(board_size: 10)

      expect(algebraic_string).to eq('j9')
    end
  end

  describe '#traverse' do
    subject(:traverse_coordinate) { described_class.from_string('e4') }

    it 'traverses vertically' do
      direction = Piece::HORIZONTAL_VERTICAL[:up]
      up_coordinate = traverse_coordinate.traverse(direction)
      result = up_coordinate.to_s

      expect(result).to eq('e5')
    end

    it 'traverses horizontally' do
      direction = Piece::HORIZONTAL_VERTICAL[:left]
      up_coordinate = traverse_coordinate.traverse(direction)
      result = up_coordinate.to_s

      expect(result).to eq('d4')
    end

    it 'traverses diagonally' do
      direction = Piece::DIAGONAL[:down_right]
      up_coordinate = traverse_coordinate.traverse(direction)
      result = up_coordinate.to_s

      expect(result).to eq('f3')
    end

    it 'traverses a knight move' do
      direction = Knight::KNIGHT_MOVES[0]
      up_coordinate = traverse_coordinate.traverse(direction)
      result = up_coordinate.to_s

      expect(result).to eq('d6')
    end

    it 'traverses a random multistep direction' do
      direction = [3, 3]
      up_coordinate = traverse_coordinate.traverse(direction)
      result = up_coordinate.to_s

      expect(result).to eq('h1')
    end
  end

  describe '#==' do
    subject(:equality_coordinate) { described_class.new(row: 3, column: 5) }

    it 'recognizes equal coordinates as having the same column and row attributes' do
      equal_coordinate = Coordinate.new(row: 3, column: 5)

      expect(equal_coordinate).to eq(equality_coordinate)
    end

    it 'recognizes different coordinates as having the same column and row attributes' do
      different_coordinate = Coordinate.new(row: 7, column: 5)

      expect(different_coordinate).not_to eq(equality_coordinate)
    end
  end
end
