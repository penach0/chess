require_relative 'chess'
# This class is responsible for building Path objects
class PathFactory
  def self.create_paths(board, coordinate, piece)
    paths = []
    piece.movement.each do |type, directions|
      case type
      when :attacking
        directions.map { |direction| paths << AttackingPath.new(board, coordinate, direction, steps: piece.steps) }
      else
        directions.map { |direction| paths << Path.new(board, coordinate, direction, steps: piece.steps) }
      end
    end
    Paths.new(paths)
  end
end
