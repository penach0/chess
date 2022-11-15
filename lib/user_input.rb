require_relative 'chess'
# This module will methods that query the user for input
module UserInput
  include Coordinates

  # UNDO = 'undo'.freeze

  def ask_name(color)
    print "Who wants to play #{color}? Tell me your name: "
    gets.chomp
  end

  def ask_coordinate(message, player_name = nil)
    print display_message(message, player_name)
    loop do
      input = gets.chomp
      return input if valid_coordinate?(input) # || input == UNDO

      print display_message(:invalid_coordinate)
    end
  end

  private

  def display_message(message, player_name = nil)
    {
      start_square: "#{player_name} insert the coordinate of the piece you want to move: ",
      end_square: 'Insert the coordinate of the destination square: ',
      invalid_coordinate: 'That coordinate is not valid. Please try again: '
    }[message]
  end
end
