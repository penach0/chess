require_relative 'user_input'

# Represents a Game
class Game
  include UserInput
  attr_reader :board, :black_player, :white_player

  def initialize(board: nil, black_player: nil, white_player: nil)
    @board = board || Board.new
    @black_player = black_player || Player.new('black')
    @white_player = white_player || Player.new('white')
  end

  def setup
    board.print_board
    black_player.place_pieces(board)
    white_player.place_pieces(board)
    board.print_board
    p black_player.piece
  end

  def playing
    5.times do
      black_player.make_move(board, ask_coordinate(:start_square), ask_coordinate(:end_square))
      board.print_board
    end
  end
end
