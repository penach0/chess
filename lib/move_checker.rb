require_relative 'chess'
# This module will find the allowed moves from
# the available paths given the board state
module MoveChecker
  include Coordinates

  def allowed_moves(path, piece)
    piece_index = coordinate_index(path, piece.position)
    backward = path[0, piece_index].reverse
    forward = path[piece_index + 1, path.length]

    backward_path = allowed_in_direction(backward, first_piece_index(backward), piece)
    forward_path = allowed_in_direction(forward, first_piece_index(forward), piece)

    backward_path + forward_path
  end

  def piece_scope(path, piece)
    piece_index = coordinate_index(path, piece.position)
    backward = path[0, piece_index].reverse
    forward = path[piece_index + 1, path.length]

    backward_scope = scope_in_direction(backward, first_piece_index(backward))
    forward_scope = scope_in_direction(forward, first_piece_index(forward))

    backward_scope + forward_scope
  end

  private

  def scope_in_direction(path, first_piece_index)
    return path if path_empty?(path)

    path[0, first_piece_index + 1]
  end

  def allowed_in_direction(path, first_piece_index, piece)
    return path if path_empty?(path)
    return path[0, first_piece_index] if piece.same_color?(first_piece(path))

    path[0, first_piece_index + 1]
  end

  def first_piece_index(path)
    path.index(&:occupied?)
  end

  def path_empty?(path)
    path.all?(&:empty?)
  end

  def first_piece(path)
    path[first_piece_index(path)].piece
  end

  def coordinate_index(path, coordinate)
    path.index { |square| square.coordinate == coordinate }
  end
end
