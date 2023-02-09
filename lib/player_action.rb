require_relative 'chess'
# This class takes in an input from the player and decides an execution
# path based on the action the user wants to perform (save, quit, move)
class PlayerAction
  attr_reader :input

  VALID_COORDINATE = /^[a-h][1-8]$/

  def initialize(input, game)
    @input = input
    @game = game
  end

  def dispatch_action
    case input
    when 'save'
      game.save
    when 'quit'
      game.quit
    when VALID_COORDINATE
      Move.validate_starting(game.board, game.current_player, input)
    end
  end
end
