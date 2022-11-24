require_relative 'chess'

# Represents a Chessboard
class Board
  include Coordinates
  include Directions
  include FENTranslator
  attr_reader :board

  def initialize(board: '8/8/8/8/8/8/8/8')
    @board = squarify_board(fen_to_array(board))
  end

  def square(coordinate)
    board.flatten.find { |element| element.coordinate == coordinate }
  end

  def piece_in(coordinate)
    square(coordinate).piece
  end

  def pieces_of_color(color)
    board.flatten
         .filter_map { |square| square.piece if square.occupied?(color) }
  end

  def move_piece(start_coordinate, end_coordinate)
    stored_piece = piece_in(start_coordinate)

    remove_piece(start_coordinate)
    place_piece(stored_piece, end_coordinate)
  end

  def squares_attacked_by(color)
    pieces_of_color(color).map { |piece| piece.attacking(self) }
                          .flatten
                          .uniq
  end

  def print_board
    board.each do |line|
      puts line.join
    end
    puts
  end

  # From Directions

  def find_paths(position, direction)
    direction.select { |path| check_path(path, position) }
  end

  def adjacent_squares(path, position)

  end

  private

  def place_piece(piece, end_coordinate)
    square(end_coordinate).update(piece)
  end

  def remove_piece(coordinate)
    square(coordinate).clear
  end

  def squarify_board(board)
    board.map.with_index do |line, row_index|
      squarify_line(line, row_index)
    end
  end

  def squarify_line(line, row_index)
    line.map.with_index do |element, col_index|
      coordinate = array_to_algebraic(row_index, col_index)
      color = Square.color(row_index, col_index)
      Square.new(element, coordinate, color)
    end
  end

  # From Directions

  def check_path(path, position)
    square_to_coordinates(path).include?(position)
  end

  def all_directions
    straight_lines + diagonals
  end

  def straight_lines
    lines + columns
  end

  def lines
    board
  end

  def columns
    board.transpose
  end

  def l_shape(position)
    coordinate = algebraic_to_array(position)
    possible_squares = []

    KNIGHT_MOVES.each do |direction|
      row, column = knight_jump(coordinate, direction)
      possible_squares << board[row][column] if valid_position?(row, column)
    end

    possible_squares
  end

  def knight_jump(coordinate, direction)
    row = coordinate[0] + direction[0]
    column = coordinate[1] + direction[1]

    [row, column]
  end

  def diagonals
    main_diagonals + anti_diagonals
  end

  def anti_diagonals
    main_diagonals(board.transpose.reverse)
  end

  def main_diagonals
    diagonals = diagonals_from_top + diagonals_from_side

    diagonals.select { |diagonal| diagonal.size > 1 }
  end

  def diagonals_from_top
    diagonals = []
    lines.first.each_index do |column|
      diagonals << single_diagonal(0, column)
    end
    diagonals
  end

  def diagonals_from_side
    diagonals = []
    columns.first.each_index do |row|
      next if row.zero?

      diagonals << single_diagonal(row, 0)
    end
    diagonals
  end

  def single_diagonal(row, column)
    diagonal = []
    while valid_position?(row, column)
      diagonal << board[row][column]
      row += 1
      column += 1
    end
    diagonal
  end

  def valid_position?(row, column)
    [row, column].all? { |el| el.between?(0, SIZE - 1) }
  end

end
