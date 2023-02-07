require_relative 'chess'
include UserInput

def save_files
  remove_extension = ->(file) { file.delete_suffix('.txt') }

  Dir.children('saves').map { |file| remove_extension.call(file) }
end

yes_or_no?(:load_game) ? Game.load('test') : Game.new.playing
