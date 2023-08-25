require_relative '../lib/chess'

describe Player do
  let(:player_board) { Board.new(fen: '5k2/5P2/5K2/8/8/8/8/8') }

  describe '#no_moves?' do
    let(:black_player) { described_class.new('black', 'Johnny') }
    let(:white_player) { described_class.new('white', 'Johnny') }

    it 'returns true if a player has no moves' do
      expect(black_player).to be_no_moves(player_board)
    end

    it 'returns false if a player has no moves' do
      expect(white_player).not_to be_no_moves(player_board)
    end
  end
end
