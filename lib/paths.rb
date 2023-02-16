require_relative 'chess'
# This class describes an array of paths available to a piece
class Paths
  attr_accessor :paths

  def initialize(paths)
    @paths = paths
  end

  def possible_destinations
    paths.map(&:piece_scope)
  end
end
