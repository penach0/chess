require_relative 'coordinates'

# This module will methods that query the user for input
module UserInput
  include Coordinates

  # UNDO = 'undo'.freeze

  def ask_coordinate(message)
    print display_message(message)
    loop do
      input = gets.chomp
      return input if valid_coordinate?(input) # || input == UNDO

      print display_message(:invalid_coordinate)
    end
  end

  def display_message(message)
    {
      start_square: 'Insert the coordinate of the piece you want to move: ',
      end_square: 'Insert the coordinate of the destination square: ',
      invalid_coordinate: 'That coordinate is not valid. Please try again: '
    }[message]
  end
end
