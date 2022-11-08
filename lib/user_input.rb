require_relative 'coordinates'

# This module will methods that query the user for input
module UserInput
  include Coordinates

  def ask_coordinate(message)
    print display_message(message)
    loop do
      coordinate = gets.chomp
      return coordinate if valid_coordinate?(coordinate)

      print display_message(:invalid_coordinate)
    end
  end

  def ask_end_square
    print 'Insert the coordinate of the destination square: '
    loop do
      coordinate = gets.chomp
      return coordinate if valid_coordinate?(coordinate)

      print 'That coordinate is not valid. Please try again: '
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