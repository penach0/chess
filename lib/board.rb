require_relative 'chess'
# Represents a Chessboard
class Board
  include FENTranslator
  attr_reader :board

  SIZE = 8

  CASTLING_POSSIBILITIES = {['e1', 'g1'] => ['h1', 'f1'],
                            ['e1', 'c1'] => ['a1', 'd1'],
                            ['e8', 'g8'] => ['h8', 'f8'],
                            ['e8', 'c8'] => ['a8', 'd8']}.freeze

  def self.inside_board?(coordinate)
    [coordinate.row, coordinate.column].all? { |el| el.between?(0, SIZE - 1) }
  end

  def initialize(board: '8/8/8/8/8/8/8/8')
    @board = squarify_board(fen_to_array(board))
  end

  def square(coordinate)
    row, column = Coordinate.to_array(coordinate)
    board[row][column]
  end

  def piece_in(coordinate)
    square(coordinate).piece
  end

  def pieces_of_color(color)
    board.flatten
         .filter_map { |square| square.piece if square.occupied?(color) }
  end

  def castle(start_coordinate, end_coordinate)
    castling_direction = [start_coordinate, end_coordinate]
    move_piece(start_coordinate, end_coordinate)

    rook_start, rook_end = CASTLING_POSSIBILITIES[castling_direction]
    move_piece(rook_start, rook_end)
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

  def find_single_moves(position, move_type)
    move_type.filter_map do |direction|
      row, column = single_move(position, direction)

      board[row][column] if Board.inside_board?(row, column)
    end
  end

  def find_paths(position, directions)
    directions.each_value.map { |direction| path_in_direction(position, direction) }
  end

  def path_in_direction(position, direction)
    coordinate = position.traverse(direction)
    path = []
    while Board.inside_board?(coordinate)
      path << square(coordinate)
      coordinate = coordinate.traverse(direction)
    end
    path
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
    line.map.with_index do |fen, col_index|
      Square.new(row_index, col_index, fen)
    end
  end

  # From Directions

  def lines
    board
  end

  def columns
    board.transpose
  end

  def single_move(coordinate, direction)
    row = coordinate.row + direction[0]
    column = coordinate.column + direction[1]

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
    while Board.inside_board?(row, column)
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
end
