require_relative '../lib/chess'

describe BoardDecoder do
  describe '.decode' do
    let(:decode_board) { Board.new(fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR') }

    it 'decodes a board back into a fen string' do
      decode_board.move_piece(Move.new(Coordinate.from_string('e2'), Coordinate.from_string('e4')))
      board_array = decode_board.board
      result = described_class.decode(board_array)

      expect(result).to eq('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR')
    end
  end
end
