require_relative 'chess'
include UserInput

loop do
  GameLauncher.run

  break unless yes_or_no?(:play_again)
end
