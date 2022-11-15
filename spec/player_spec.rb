require_relative '../lib/chess'

describe Player do
  let(:player_board) { Board.new(board: '7b/6b1/2B5/8/8/b7/8/8') }
  subject(:player) { described_class.new('black', player_board, 'Johnny') }

  describe '#movable_pieces' do
    it 'returns an array of all Piece objects that are movable' do
      movable_piece_array = player.movable_pieces(player_board)
      movable_pieces_positions = movable_piece_array.map(&:position)

      movable_piece_array.all? { |piece| expect(piece).to be_a_kind_of(Piece) }
      expect(movable_pieces_positions).to eq(['g7', 'a3'])
    end
  end

  describe '#piece_positions' do
    it 'returns all of the Player pieces when no argument is given' do
      positions = player.piece_positions

      expect(positions).to eq(['h8', 'g7', 'a3'])
    end

    it 'returns the given Pieces positions they are passed as an argument' do
      pieces_needed = [instance_double('Piece', position: 'a3'),
                       instance_double('Piece', position: 'd4'),
                       instance_double('Piece', position: 'h6')]
      needed_positions = player.piece_positions(pieces_needed)

      expect(needed_positions).to eq(['a3', 'd4', 'h6'])
    end
  end

  describe '#make_move' do
    it 'sends :new to Move with the correct arguments' do
      move = class_double('Move').as_stubbed_const

      expect(move).to receive(:execute).with(player_board, player)
      player.make_move(player_board)
    end
  end
end
