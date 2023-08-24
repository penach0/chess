require_relative '../lib/chess'

describe BoardBuilder do
  describe '.build' do
    let(:built_board_array) { Board.new(fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR').board }

    it 'builds a board from a fen string' do
      fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
      result = described_class.build(fen_string)

      expect(result).to eq(built_board_array)
    end
  end
end
