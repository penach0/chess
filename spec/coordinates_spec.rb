require_relative '../lib/coordinates'
include Coordinates

describe Coordinates do
  describe '#valid_coordinate?' do
    context 'when the coordinate is valid' do
      it 'retuns true' do
        ALL_COORDINATES.each { |coordinate| expect(coordinate).to be_valid_coordinate(coordinate) }
      end
    end

    context 'when the coordinate is invalid' do
      it 'returns false' do
        invalid_values = ['a10', 'blue', 9]

        invalid_values.each { |value| expect(value).not_to be_valid_coordinate(value) }
      end
    end
  end

  describe '#square_to_coordinates' do
    it 'returns the coordinates of the squares' do
      squares = [instance_double('Square', coordinate: 'a1'),
                 instance_double('Square', coordinate: 'b7'),
                 instance_double('Square', coordinate: 'f5')]

      coordinates = square_to_coordinates(squares)

      expect(coordinates).to eq(['a1', 'b7', 'f5'])
    end
  end

  describe '#array_to_algebraic' do
    it 'converts any row-column combination to algebraic coordinates' do
      all_coordinates =
        (0..SIZE - 1).map do |row|
          (0..SIZE - 1).map { |column| array_to_algebraic(row, column) }
        end.flatten.sort

      expect(all_coordinates).to eq(ALL_COORDINATES.sort)
    end
  end
end
