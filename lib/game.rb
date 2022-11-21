require_relative 'chess'

# Represents a Game
class Game
  attr_reader :board, :black_player, :white_player, :current_player

  def initialize(board: 'rnbq1bnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQ1BNR')
    @board = Board.new(board: board)
    @white_player = Player.new('white', @board)
    @black_player = Player.new('black', @board)
    @current_player = @white_player
  end

  def setup
    board.print_board
  end

  def playing
    5.times do
      full_move
    end
  end

  def half_move
    current_player.make_move(board)
    board.print_board
    change_player
  end

  def full_move
    2.times { half_move }
  end

  private

  def change_player
    @current_player = (@current_player == white_player ? black_player : white_player)
  end
end
