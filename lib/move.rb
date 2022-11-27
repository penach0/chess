require_relative 'chess'
# This class will describe a move to be made by a player
class Move
  include UserInput
  include MoveChecker
  attr_reader :board, :player, :starting, :ending

  CASTLING_POSSIBILITIES = [['e1', 'g1'], ['e1', 'c1'],
                            ['e8', 'g8'], ['e8', 'c8']].freeze

  def self.execute(board, player)
    new(board, player).execute
  end

  def initialize(board, player)
    @board = board
    @player = player
    @starting = validation(ask_coordinate(:start_square, player.name), available_starting)
    @ending = validation(ask_coordinate(:end_square), available_ending)
  end

  def execute
    return board.castle(starting, ending) if CASTLING_POSSIBILITIES.include?([starting, ending])

    board.move_piece(starting, ending)
  end

  private

  def validation(input, available_options)
    return input if available_options.include?(input)

    validation(ask_coordinate(:invalid_coordinate), available_options)
  end

  def available_starting
    player.movable_pieces(board).map { |piece| piece.position.algebraic }
  end

  def available_ending
    possible_moves = board.piece_in(algebraic: starting).possible_moves(board)

    Coordinate.square_to_coordinates(possible_moves)
  end
end
