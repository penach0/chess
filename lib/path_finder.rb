require_relative 'chess'
# This module holds functions responsible for finding
# the paths available for pieces
module PathFinder
  def find_paths(position, direction)
    direction.select { |path| check_path(path, position) }
  end

  def check_path(path, position)
    square_to_coordinates(path).include?(position)
  end
end