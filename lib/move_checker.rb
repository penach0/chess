require_relative 'user_input'
# This module will validate user input for moves
# against board state
module MoveChecker
  include UserInput

  def allowed_moves(path, piece)
    piece_index = coordinate_index(path, piece.position)
    backward = path[0, piece_index].reverse
    forward = path[piece_index + 1, path.length]

    backward_path = allowed_in_direction(backward, first_piece_index(backward), piece)
    forward_path = allowed_in_direction(forward, first_piece_index(forward), piece)

    square_to_coordinates(backward_path + forward_path)
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

  # TODO: Decide the best place for this method
  def square_to_coordinates(squares)
    squares.map { |square| square.coordinate }
  end
end