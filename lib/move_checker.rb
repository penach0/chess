require_relative 'chess'
# This module will find the allowed moves from
# the available paths given the board state
module MoveChecker
  def piece_scope(path, piece)
    return path if path_empty?(path)

    path[0, blocking_piece_index(path) + 1]
  end

  private

  def forbidden_move(square, piece)
    square.piece.same_color?(piece)
  end

  def blocking_piece_index(path)
    path.index(&:occupied?)
  end

  def path_empty?(path)
    path.all?(&:empty?)
  end
end
