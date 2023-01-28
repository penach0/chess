require_relative 'chess'
# This module will find the allowed moves from
# the available paths given the board state
module MoveChecker
  def piece_scope(path)
    return path if path_empty?(path)

    path[0, blocking_piece_index(path) + 1]
  end

  def path_pieces(path)
    path.map(&:piece)
  end

  private

  def forbidden_move(board, square, piece)
    square.piece.same_color?(piece) || moves_into_check?(board, square, piece)
  end

  def moves_into_check?(board, square, piece)
    board_dup = board.clone

    board_dup.move_piece(piece.position, square.coordinate)

    board_dup.in_check?(piece.color)
  end

  def blocking_piece_index(path)
    path.index(&:occupied?)
  end

  def path_empty?(path)
    path.all?(&:empty?)
  end
end
