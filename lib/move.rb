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

  def validation(coordinate, available_options)
    return coordinate if available_options.include?(coordinate)

    validation(ask_coordinate(:invalid_coordinate), available_options)
  end

  def available_starting
    board.position_of_pieces(player.color)
  end

  def available_ending
    board.piece_in(starting).possible_moves(board)
  end

  def execute
    board.move_piece(starting, ending)
  end
end
