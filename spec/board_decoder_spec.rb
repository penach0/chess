require_relative '../lib/chess'

describe BoardDecoder do
  describe '#fen_string' do
    subject(:board) { Board.new(board: '2b2b2/8/7b/8/8/8/B7/2B2B2') }

    it 'decodes the board into a fen string correctly' do
      expect(fen_string(board.board)).to eq('2b2b2/8/7b/8/8/8/B7/2B2B2')
    end
  end
end
