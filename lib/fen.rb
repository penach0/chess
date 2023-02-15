# This class represents a FEN string
class FEN
  attr_reader :board, :current_player

  def initialize(string)
    fields = string.split

    @board = fields[0]
    @current_player = fields[1]
  end
end
