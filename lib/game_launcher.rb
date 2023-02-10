require_relative 'chess'
# This class encapsulates the logic prompting the user to start a game
# either new or from a save
class GameLauncher
  attr_reader :saves, :game

  def self.run
    loop do
      Output.starting_screen
      new.run_game

      break unless UserInput.yes_or_no?(:play_again)
    end
  end

  def initialize
    @saves = save_files
    @game = new_or_load
  end

  def run_game
    Output.board(game.board)

    half_move until game.over?

    end_message
  end

  def half_move
    input = UserInput.ask_coordinate(:start_square, player_name: game.current_player.name)

    PlayerAction.dispatch(input, game)

    Output.board(game.board)
  end

  def end_message
    Output.message(:win, player_name: game.current_player.name) if game.checkmate?
    Output.message(:draw) if game.draw?
  end

  def new_or_load
    return GameState.new if save_files.empty?

    UserInput.yes_or_no?(:load_game) ? GameState.load(pick_save_file) : GameState.new
  end

  def pick_save_file
    Output.ordered_list(save_files)
    UserInput.pick_option(save_files)
  end

  def save_files
    remove_extension = ->(file) { file.delete_suffix('.txt') }

    Dir.children('saves').map(&remove_extension)
  end
end
