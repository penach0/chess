require_relative 'chess'
# This module contains messages and text to be displayed on the screen
module Output
  def display_message(message, player_name = nil)
    {
      start_square: "#{player_name} insert the coordinate of the piece you want to move: ",
      end_square: 'Insert the coordinate of the destination square: ',
      invalid_coordinate: 'That coordinate is not valid. Please try again: '
    }[message]
  end
end