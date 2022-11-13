require_relative '../lib/chess'

WHITE_PIECE_FEN = 'B'.freeze
BLACK_PIECE_FEN = 'b'.freeze
NO_PIECE_FEN = ' '.freeze

describe Square do
  describe '.color' do
    it 'returns light if the coordinate sum is even' do
      row = 2
      column = 2
      result = described_class.color(row, column)
      expect(result).to eq('light')
    end

    it 'returns dark if the coordinate sum is odd' do
      row = 3
      column = 2
      result = described_class.color(row, column)
      expect(result).to eq('dark')
    end
  end

  describe '#initialize' do
    it 'sends message .for to Piece class' do
      expect(Piece).to receive(:for)

      described_class.new(BLACK_PIECE_FEN, 'd4', 'black')
    end
  end

  describe '#update' do
    subject(:update_square) { described_class.new(BLACK_PIECE_FEN, 'd4', 'black') }
    let(:new_piece) { instance_double('Bishop', position: 'e5', color: 'white', fen_value: WHITE_PIECE_FEN) }

    it 'sends message #captured to current piece' do
      allow(new_piece).to receive(:update_position)
      current_piece = update_square.piece

      expect(current_piece).to receive(:captured)
      update_square.update(new_piece)
    end

    it 'sets current piece to new piece' do
      allow(new_piece).to receive(:update_position)
      update_square.update(new_piece)
      current_piece = update_square.piece

      expect(current_piece).to be(new_piece)
    end

    it 'sends message to new piece to update its position attribute' do
      expect(new_piece).to receive(:update_position).with('d4')

      update_square.update(new_piece)
    end
  end

  describe '#clear' do
    let(:occupied_square) { described_class.new(BLACK_PIECE_FEN, 'd4', 'black') }

    it 'sets piece attribute to a null piece' do
      occupied_square.clear
      result = occupied_square.piece

      expect(result).to be_an_instance_of(NoPiece)
    end
  end

  describe '#empty?' do
    context 'when empty' do
      let(:empty_square) { described_class.new(NO_PIECE_FEN, 'd4', 'black') }

      it 'returns true' do
        expect(empty_square).to be_empty
      end
    end
    context 'when occupied' do
      let(:occupied_square) { described_class.new(BLACK_PIECE_FEN, 'd4', 'black') }

      it 'returns false' do
        expect(occupied_square).not_to be_empty
      end
    end
  end

  describe '#occupied?' do
    context 'when empty' do
      let(:empty_square) { described_class.new(NO_PIECE_FEN, 'd4', 'black') }

      it 'returns false' do
        expect(empty_square).not_to be_occupied
      end
    end
    context 'when occupied' do
      let(:white_square) { described_class.new(WHITE_PIECE_FEN, 'd4', 'black') }

      it 'returns true if the piece color matches the passed argument' do
        color = 'white'
        expect(white_square).to be_occupied(color)
      end

      it 'returns false if the piece color does not match the passed argument' do
        color = 'black'
        expect(white_square).not_to be_occupied(color)
      end

      it 'returns true if the square holds a piece and no argument is passed' do
        expect(white_square).to be_occupied
      end
    end
  end
end
