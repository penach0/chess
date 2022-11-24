require_relative 'chess'

# Represents a Chessboard
class Board
  include Coordinates
  include FENTranslator
  attr_reader :board

  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
                  [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  PAWN_ATTACKING_DIRECTIONS = { 'white' => [[-1, -1], [-1, 1]],
                                'black' => [[1, -1], [1, 1]] }.freeze

  PAWN_FORWARD_DIRECTIONS = { 'white' => [-1, -2], 'black' => [1, 2] }.freeze

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

  def all_directions
    straight_lines + diagonals
  end

  def straight_lines
    lines + columns
  end

  def diagonals
    main_diagonals('main') + main_diagonals('anti')
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

  def pawn_forward_path(position, color)
    row, column = algebraic_to_array(position)
    direction = PAWN_FORWARD_DIRECTIONS[color]

    first_square = board[row + direction[0]][column]
    second_square = board[row + direction[1]][column]

    [first_square, second_square]
  end

  def pawn_attacked_squares(position, color)
    row, column = algebraic_to_array(position)
    directions = PAWN_ATTACKING_DIRECTIONS[color]
    attacked = []

    directions.each do |direction|
      next unless valid_position?(row + direction[0], column + direction[1])

      attacked << board[row + direction[0]][column + direction[1]]
    end

    attacked
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

  def lines
    board
  end

  def columns
    board.transpose
  end

  def knight_jump(coordinate, direction)
    row = coordinate[0] + direction[0]
    column = coordinate[1] + direction[1]

    [row, column]
  end

  def anti_diagonals
    main_diagonals(board.transpose.reverse)
  end

  def main_diagonals(direction)
    diagonals = diagonals_from_top(direction) + diagonals_from_side(direction)

    diagonals.select { |diagonal| diagonal.size > 1 }
  end

  def diagonals_from_top(direction)
    diagonals = []
    lines.first.each_index do |column|
      diagonals << single_diagonal(0, column, direction)
    end
    diagonals
  end

  def diagonals_from_side(direction)
    diagonals = []
    columns.first.each_index do |row|
      next if row.zero?

      diagonals << single_diagonal(row, 0, direction)
    end
    diagonals
  end

  def single_diagonal(row, column, direction)
    diagonals_board = board_direction(direction)
    diagonal = []
    while valid_position?(row, column)
      diagonal << diagonals_board[row][column]
      row += 1
      column += 1
    end
    diagonal
  end

  def board_direction(direction)
    case direction 
    when 'main'
      board
    when 'anti'
      board.transpose.reverse
    end
  end

  def valid_position?(row, column)
    [row, column].all? { |el| el.between?(0, SIZE - 1) }
  end
end
