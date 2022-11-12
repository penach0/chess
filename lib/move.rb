require_relative 'move_checker'
# This class will describe a move to be made by a player
class Move
  include UserInput
  include MoveChecker
  attr_reader :board, :player, :starting, :ending

  def self.execute(board, player)
    new(board, player).execute
  end

  def initialize(board, player)
    @board = board
    @player = player
    @starting = validation(ask_coordinate(:start_square), available_starting)
    @ending = validation(ask_coordinate(:end_square), available_ending)
  end

  def validation(input, available_options)
    # available_options = undo if input == UNDO
    return input if available_options.include?(input)

    validation(ask_coordinate(:invalid_coordinate), available_options)
  end

  # Fix bug related to picking a right colored piece with no moves
  def available_starting
    player.piece_positions
  end

  def available_ending
    board.piece_in(starting).possible_moves(board)
  end

  # Not correctly implemented
  def undo
    @starting = validation(ask_coordinate(:start_square), available_starting)
    available_ending
  end

  def execute
    board.move_piece(starting, ending)
  end
end
