require_relative 'chess'
# This class encapsulates the logic prompting the user to start a game
# either new or from a save
class GameLauncher
  include UserInput
  attr_reader :saves

  def self.run
    new.user_choice
  end

  def initialize
    @saves = save_files
  end

  def user_choice
    return Game.new.playing if save_files.empty? 

    yes_or_no?(:load_game) ? Game.load(pick_save_file) : Game.new.playing
  end

  def save_files
    remove_extension = ->(file) { file.delete_suffix('.txt') }
  
    Dir.children('saves').map(&remove_extension)
  end

  def pick_save_file
    display_ordered_list(save_files)
    pick_option(save_files)
  end
end