require_relative '../chess'
# This class represents a chess piece
# Specific pieces are descendent from it
class Piece
  include PathFinder
  include MoveChecker
  attr_reader :color, :symbol, :position, :fen_value

  DIAGONAL = {
    up_right: [-1, 1],
    up_left: [-1, -1],
    down_right: [1, 1],
    down_left: [1, -1]
  }.freeze

  HORIZONTAL_VERTICAL = {
    right: [0, 1],
    left: [0, -1],
    up: [-1, 0],
    down: [1, 0]
  }.freeze

  ALL_DIRECTIONS = DIAGONAL.merge(HORIZONTAL_VERTICAL)

  def self.for(fen, position)
    case fen
    when 'K' then King.new(position, 'white', fen)
    when 'Q' then Queen.new(position, 'white', fen)
    when 'R' then Rook.new(position, 'white', fen)
    when 'B' then Bishop.new(position, 'white', fen)
    when 'N' then Knight.new(position, 'white', fen)
    when 'P' then Pawn.new(position, 'white', fen)
    when 'k' then King.new(position, 'black', fen)
    when 'q' then Queen.new(position, 'black', fen)
    when 'r' then Rook.new(position, 'black', fen)
    when 'b' then Bishop.new(position, 'black', fen)
    when 'n' then Knight.new(position, 'black', fen)
    when 'p' then Pawn.new(position, 'black', fen)
    else NoPiece.new(position, nil, fen)
    end
  end

  def initialize(position, color, fen_value)
    @position = position
    @color = color
    @fen_value = fen_value
  end

  def movable?(board)
    return if off_board?

    !possible_moves(board).empty?
  end

  def possible_moves(board)
    attacking(board).reject { |square| forbidden_move(square, self) }
  end

  def attacking(board)
    attacking_paths(board).flatten
  end

  def attacking_paths(board)
    available_paths(board).map { |path| piece_scope(path) }
  end

  def attacking_king?(board)
    attacking(board).any? do |square|
      piece = square.piece

      piece.king?(opponent_color)
    end
  end

  def checking_line(board)
    checking_line =
      attacking_paths(board).find do |path|
        pieces = path_pieces(path)

        pieces.last.king?(opponent_color)
      end
    checking_line.pop

    checking_line
  end

  def king?(passed_color)
    is_a?(King) && color == passed_color
  end

  def update_position(new_position)
    @position = new_position
  end

  def same_color?(other)
    color == other.color
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def null?
    !color
  end

  def captured
    @position = nil
  end

  private

  def off_board?
    !position
  end

  def to_s
    symbol
  end
end
