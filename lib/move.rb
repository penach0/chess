require_relative 'chess'
# This class describes a move to be made by a player
class Move
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def to_s
    "#{from}-#{to.algebraic}"
  end
end
