# Represents a Game
class Game
  def initialize(board: nil, black_player: nil)
    @board = board || Board.new
    @black_player = black_player || Player.new('black')
  end
end
