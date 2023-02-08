require_relative 'chess'
# This class encapsulates the logic prompting the user to start a game
# either new or from a save
class GameLauncher
  attr_reader :saves

  def self.run
    loop do
      new.new_or_load

      break unless UserInput.yes_or_no?(:play_again)
    end
  end

  def initialize
    @saves = save_files
  end

  def new_or_load
    return Game.new.playing if save_files.empty?

    UserInput.yes_or_no?(:load_game) ? Game.load(pick_save_file) : Game.new_game
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
