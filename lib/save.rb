require_relative 'chess'
# This class creates a file containing a save
class Save
  include UserInput
  attr_reader :fen_string

  def initialize(fen_string)
    @fen_string = fen_string
  end

  def write_to_file
    File.write("saves/#{ask_save_name}.txt", fen_string)
  end
end