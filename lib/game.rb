require_relative 'chess'

# Represents a Game
class Game
  attr_reader :board, :black_player, :white_player, :current_player

  def initialize(board: 'r1bq1b1r/8/8/8/8/8/8/R1BQ1B1R')
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
