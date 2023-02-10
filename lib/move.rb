require_relative 'chess'
# This class will describe a move to be made by a player
class Move
  attr_reader :board, :player, :starting, :ending

  def self.execute(board, player, input)
    new(board, player, input).execute
  end

  def initialize(board, player, input)
    @board = board
    @player = player
    @starting = validation(input, available_starting)
    @ending = validation(UserInput.ask_coordinate(:end_square), available_ending)
  end

  def execute
    board.move_piece(starting, ending)
  end

  private

  def validation(input, available_options)
    return input if available_options.include?(input)

    validation(UserInput.ask_coordinate(:invalid, input: 'coordinate'), available_options)
  end

  def available_starting
    player.movable_pieces(board).map { |piece| piece.position.algebraic }
  end

  def available_ending
    possible_moves = board.piece_in(starting).possible_moves(board)

    Coordinate.square_to_coordinates(possible_moves)
  end
end
