require_relative 'coordinates'

# This module will methods that query the user for input
module UserInput
  include Coordinates

  def ask_start_square
    print 'Insert the coordinate of the piece you want to move: '
    loop do
      coordinate = gets.chomp
      return coordinate if valid_coordinate?(coordinate)

      print 'That coordinate is not valid. Please try again: '
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
end