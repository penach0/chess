require_relative '../lib/square'

describe Square do
  describe '#occupied?' do
    let(:empty_square) { described_class.new('   ', 4, 3) }
    let(:occupied_square) { described_class.new(' ♝ ', 4, 3) }

    it 'returns false when empty' do
      expect(empty_square).not_to be_occupied
    end

    it 'returns true when occupied' do
      expect(occupied_square).to be_occupied
    end
  end
end
