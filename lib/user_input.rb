require_relative 'chess'
# This module will methods that query the user for input
module UserInput
  include Output
  # UNDO = 'undo'.freeze

  def ask_name(color)
    print "Who wants to play #{color}? Tell me your name: "
    gets.chomp
  end

  def ask_coordinate(message, player_name = nil)
    print display_message(message, player_name: player_name)
    loop do
      input = gets.chomp.downcase
      return input if Coordinate.valid?(input)

      print display_message(:invalid, input: 'coordinate')
    end
  end
end
