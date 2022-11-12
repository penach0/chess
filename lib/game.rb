require_relative 'user_input'

# Represents a Game
class Game
  include UserInput
  attr_reader :board, :black_player, :white_player, :current_player

  def initialize(board: '2b2b2/8/7b/8/8/8/B7/2B2B2')
    @board = Board.new(board: board)
    @black_player = Player.new('black', @board)
    @white_player = Player.new('white', @board)
    @current_player = @white_player
  end

  def setup
    board.print_board
  end

  def playing
    5.times do
      turn
    end
  end

  def half_move
    current_player.make_move(board)
    board.print_board
    change_player
  end

  def turn
    2.times { half_move }
  end

  private

  def change_player
    @current_player = (@current_player == white_player ? black_player : white_player)
  end
end
