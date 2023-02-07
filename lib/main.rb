require_relative 'chess'

loop do
  GameLauncher.run

  break unless UserInput.yes_or_no?(:play_again)
end
