require_relative 'user_input'

# Represents a Game
class Game
  include UserInput
  attr_reader :board, :black_player

  def initialize(board: nil, black_player: nil)
    @board = board || Board.new
    @black_player = black_player || Player.new('black')
  end

  def setup
    board.print_board
    black_player.place_pieces(board)
    board.print_board
    p black_player.piece
  end

  def playing
    5.times do
      black_player.make_move(board, ask_start_square, ask_end_square)
      board.print_board
    end
  end
end
