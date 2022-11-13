require_relative '../lib/chess'
include FENTranslator

describe FENTranslator do
  describe '#fen_to_array' do
    context 'when the board is empty' do
      it 'returns a 2d array of string representations' do
        fen_string = '8/8/8/8/8/8/8/8'

        expect(fen_to_array(fen_string)).to eq([[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']])
        end
    end

    context 'when the board has pieces' do
      it 'returns a 2d array of string representations' do
        fen_string = '2b2b2/8/7b/8/8/8/B7/2B2B2'

        expect(fen_to_array(fen_string)).to eq([[' ', ' ', 'b', ' ', ' ', 'b', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'b'],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                ['B', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                                [' ', ' ', 'B', ' ', ' ', 'B', ' ', ' ']])
      end
    end
  end
end
