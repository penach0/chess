require_relative 'chess'
include UserInput

yes_or_no?(:load_game) ? Game.load('test') : Game.new.playing
