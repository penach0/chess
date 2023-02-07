require_relative 'chess'
# This module contains messages and text to be displayed on the screen
module Output
  def display_message(message, player_name: nil, input: nil)
    {
      start_square: "#{player_name} insert the coordinate of the piece you want to move: ",
      end_square: 'Insert the coordinate of the destination square: ',
      invalid: "That #{input} is not valid. Please try again: ",
      win: "Congratulations #{player_name}, you won the game!!!",
      draw: 'The game is drawn, well fought by both players!!!',
      play_again: 'Do you want to play again?(y/n): ',
      save_name: 'Enter your save name: ',
      load_game: 'Do you want to load a game?(y/n): ',
      pick_option: 'Pick an option: '
    }[message]
  end

  def display_ordered_list(array)
    array.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
  end

  def display_board
    columns_indicator = "   a  b  c  d  e  f  g  h \n"

    system('clear')

    puts "#{columns_indicator}#{board}#{columns_indicator}"
  end
end
