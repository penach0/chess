require_relative 'chess'
# This module will methods that query the user for input
module UserInput
  VALID_COORDINATE = /\A[a-z]([1-9]|1[0-9]|2[0-6])\z/

  def self.ask_name(color)
    print "Who wants to play #{color}? Tell me your name: "
    gets.chomp
  end

  def self.ask_coordinate(message, player_name: nil, input: nil)
    print Output.message(message, player_name:, input:)
    loop do
      input = gets.chomp.downcase
      return input if verify_play_input(input)

      print Output.message(:invalid, input: 'coordinate')
    end
  end

  def self.ask_save_name
    print Output.message(:save_name)
    loop do
      input = gets.chomp
      return input if input.match?(/\A[\w-]+\z/)

      print Output.message(:invalid, input: 'save name')
    end
  end

  def self.pick_option(array)
    print Output.message(:pick_option)

    loop do
      input = gets.chomp
      return array[input.to_i - 1] if [*1..array.size].include?(input.to_i)
      return input if array.include?(input)

      print Output.message(:invalid, input: 'option')
    end
  end

  def self.yes_or_no?(message)
    print Output.message(message)
    loop do
      input = gets.chomp.downcase
      return true if %w[y yes].include?(input)
      return false if %w[n no].include?(input)

      print Output.message(:invalid, input: 'option')
    end
  end

  def self.verify_play_input(input)
    input == 'save' || input.match?(VALID_COORDINATE)
  end
end
