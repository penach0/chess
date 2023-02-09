require_relative 'chess'
# Represents a Game
class Game
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

  def playing
    Output.board(board)
    half_move until game_end?

    end_message
  end

  def save
    File.write("saves/#{UserInput.ask_save_name}.txt", build_save_file)
  end

  def build_save_file
    "#{white_player.name}\n#{black_player.name}\n#{fen_value}"
  end

  def fen_value
    "#{board.fen_value} #{current_player.fen_value}"
  end

  def half_move
    current_player.make_move(board)
    change_player
    Output.board(board)
  end

  def game_end?
    draw? || checkmate?
  end

  def checkmate?
    board.in_check?(current_player.color) && current_player.no_moves?(board)
  end

  def draw?
    stalemate? || insuficcient_material?
  end

  def stalemate?
    !board.in_check?(current_player.color) && current_player.no_moves?(board)
  end

  def insuficcient_material?
    remaining_pieces = board.pieces
    number_of_pieces = remaining_pieces.count

    return true if number_of_pieces == 2

    number_of_pieces == 3 && remaining_pieces.one?(&:minor_piece?)
  end

  private

  def change_player
    @current_player = (@current_player == white_player ? black_player : white_player)
  end

  def end_message
    checkmate? ? Output.message(:win, player_name: current_player.name) : Output.message(:draw)
  end
end
