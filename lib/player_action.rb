require_relative 'chess'
# This class takes in an input from the player and decides an execution
# path based on the action the user wants to perform (save, quit, move)
class PlayerAction
  attr_reader :input, :game

  VALID_COORDINATE = /^[a-h][1-8]$/

  def self.dispatch(input, game)
    new(input, game).dispatch_action
  end

  def initialize(input, game)
    @input = input
    @game = game
  end

  def dispatch_action
    case input
    when 'save'
      game.save(UserInput.ask_save_name)
    when VALID_COORDINATE
      game.update(input)
    end
  end
end
