require 'tempfile'
require_relative '../lib/chess'

describe GameState do
  NORMAL_POSITION = '8/8/2q5/7K/6Q1/8/3k4/8 w'
  STALEMATE_POSITION = '4k3/4P3/4K3/8/8/8/8/8 b'
  CHECKMATE_POSITION = '8/8/8/8/8/8/5kq1/7K w'

  def game_state(position)
    described_class.new(white_name: 'Morphy', 
                        black_name: 'Capablanca', 
                        position:)
  end

  describe '#insufficient_material?' do
    context 'when there are only kings left' do
      it 'is true' do
        only_kings_position = '8/8/8/8/1k6/8/8/5K2 w '
        
        expect(game_state(only_kings_position)).to be_insufficient_material
      end
    end

    context 'when there are only kings and 1 minor piece' do
      it 'is true' do
        minor_piece_position = '8/8/4B3/8/1k6/8/8/5K2 w'

        expect(game_state(minor_piece_position)).to be_insufficient_material
      end
    end

    context 'when there are more than 3 pieces' do
      it 'is false' do
        four_pieces_position = '8/8/4B3/8/1k4N1/8/8/5K2 w'

        expect(game_state(four_pieces_position)).not_to be_insufficient_material
      end
    end

    context 'when there are only kings and 1 major piece' do
      it 'is false' do
        major_piece_position = '8/8/3q4/8/1k6/8/8/5K2 w'

        expect(game_state(major_piece_position)).not_to be_insufficient_material
      end
    end
  end

  describe '#stalemate?' do
    context 'when the currernt player still has moves' do
      it 'is false' do
        expect(game_state(NORMAL_POSITION)).not_to be_stalemate
      end
    end
    context 'when the current player has no moves' do
      context 'and is in check'
        it 'is false' do
          expect(game_state(CHECKMATE_POSITION)).not_to be_stalemate
        end

      context 'and is not in check' do
        it 'is true' do
          expect(game_state(STALEMATE_POSITION)).to be_stalemate
        end
      end
    end
  end
end