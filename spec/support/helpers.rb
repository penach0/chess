module Helpers
  def algebraic_from_squares(squares)
    squares.map(&:algebraic)
  end  
end