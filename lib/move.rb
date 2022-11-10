require_relative 'move_checker'
# This class will describe a move to be made by a player
class Move
  include MoveChecker
  attr_reader :board, :player, :starting, :ending

  def initialize(board, player)
    @board = board
    @player = player
    @starting = start_coordinate_validation(ask_coordinate(:start_square))
    @ending = ask_coordinate(:end_square)
  end

  def start_coordinate_validation(coordinate)
    return coordinate if valid_start_coordinate?(coordinate)

    puts display_message(:invalid_coordinate)
    start_coordinate_validation(ask_coordinate(:start_square))
  end

  def valid_start_coordinate?(coordinate)
    board.square(coordinate).occupied?(player.color)
  end

  def piece_color(coordinate)
    board.piece_in(coordinate).color
  end
  
  def execute
    board.move_piece(starting, ending)
  end
end
