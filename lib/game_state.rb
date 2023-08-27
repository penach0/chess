require_relative 'chess'
# Represents and evaluates the state of a chess game
class GameState
  attr_reader :board, :black_player, :white_player, :current_player

  STARTING_POSITION = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w'.freeze

  def self.load(file)
    white_name, black_name, position = File.read("saves/#{file}.txt")
                                           .split("\n")

    new(white_name:, black_name:, position:)
  end

  def initialize(white_name: nil, black_name: nil, position: STARTING_POSITION)
    fen = FEN.new(position)

    @board = Board.new(fen: fen.board)
    @white_player = Player.new('white', white_name)
    @black_player = Player.new('black', black_name)
    @current_player = (fen.current_player == 'w' ? white_player : black_player)
  end

  def update(move)
    board.move_piece(move)
    change_player
  end

  def save(file_name)
    File.write("saves/#{file_name}.txt", build_save_file)
  end

  def build_save_file
    "#{white_player.name}\n#{black_player.name}\n#{fen_value}"
  end

  def fen_value
    "#{board.fen_value} #{current_player.fen_value}"
  end

  def over?
    draw? || checkmate?
  end

  def checkmate?
    board.in_check?(current_player.color) && current_player.without_moves?(board)
  end

  def draw?
    stalemate? || insufficient_material?
  end

  def stalemate?
    !board.in_check?(current_player.color) && current_player.without_moves?(board)
  end

  def insufficient_material?
    remaining_pieces = board.pieces
    number_of_pieces = remaining_pieces.count

    return true if number_of_pieces == 2

    number_of_pieces == 3 && remaining_pieces.one?(&:minor_piece?)
  end

  private

  def change_player
    @current_player = (@current_player == white_player ? black_player : white_player)
  end
end
