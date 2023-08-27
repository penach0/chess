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

  describe '#checkmate?' do
    context 'when the king is not in check' do
      it 'is false' do
        expect(game_state(NORMAL_POSITION)).not_to be_checkmate
      end
    end

    context 'when the king is in check' do
      context 'when the king can move' do
        it 'is false' do
          king_can_move = '8/8/1k6/8/3K4/8/1R6/2R5 b'

          expect(game_state(king_can_move)).not_to be_checkmate
        end
      end

      context 'when a piece can block' do
        it 'is false' do
          piece_can_block = '8/k7/6r1/8/3K4/8/1R6/R7 b'

          expect(game_state(piece_can_block)).not_to be_checkmate
        end
      end

      context 'when the attacking piece can be taken' do
        it 'is false' do
          piece_can_capture = '8/k5b1/8/8/8/1R1K4/8/R7 b '

          expect(game_state(piece_can_capture)).not_to be_checkmate
        end
      end

      context 'when there is no defense' do
        it 'is true' do
          expect(game_state(CHECKMATE_POSITION)).to be_checkmate
        end
      end

      context 'when the capturing piece is pinned' do
        it 'is true' do
          pinned_piece = '8/k5bQ/8/8/8/1R1K4/8/R7 b'

          expect(game_state(pinned_piece)).to be_checkmate
        end
      end

      context 'when in double check' do
        context 'when the king can move' do
          it 'is false' do
            double_check = 'r1bqk2r/pp3ppp/3p1nn1/1BpP4/5B2/2N2N2/PPP2PPP/R2QR1K1 b'

            expect(game_state(double_check)).not_to be_checkmate
          end
        end

        context 'when the king cannot move' do
          it 'is true' do
            double_check_mate = 'r1bqkb1r/pp3ppp/3p1nn1/1BpP4/5B2/2N2N2/PPP2PPP/R2QR1K1 b'

            expect(game_state(double_check_mate)).to be_checkmate
          end
        end
      end
    end
  end

  describe '#draw?' do
    context 'when it is stalemate' do
      it 'is true' do
        expect(game_state(STALEMATE_POSITION)).to be_draw
      end
    end

    context 'when it is insufficient material' do
      it 'is true' do
        insufficient_position = '8/8/8/8/1k6/8/8/5K2 w '

        expect(game_state(insufficient_position)).to be_draw
      end
    end

    context 'when it is other situation' do
      it 'is false' do
        expect(game_state(NORMAL_POSITION)).not_to be_draw
        expect(game_state(CHECKMATE_POSITION)).not_to be_draw
      end
    end
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
      context 'and is in check' do
        it 'is false' do
          expect(game_state(CHECKMATE_POSITION)).not_to be_stalemate
        end
      end

      context 'and is not in check' do
        it 'is true' do
          expect(game_state(STALEMATE_POSITION)).to be_stalemate
        end
      end
    end
  end
end