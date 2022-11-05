# Represents a Game
class Game
  attr_reader :board, :black_player

  def initialize(board: nil, black_player: nil)
    @board = board || Board.new
    @black_player = black_player || Player.new('black')
  end

  def setup
    board.print_board
    black_player.place_pieces(board)
    board.print_board
  end

  def playing
    black_player.make_move(board, 'c1', 'h6')
    board.print_board
  end
end
