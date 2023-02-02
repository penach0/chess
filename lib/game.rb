require_relative 'chess'
# Represents a Game
class Game
  include UserInput
  attr_reader :board, :black_player, :white_player, :current_player

  STARTING_POSITION = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w'.freeze

  def initialize(string: STARTING_POSITION)
    fen = FEN.new(string)

    @board = Board.new(board: fen.board)
    @white_player = Player.new('white')
    @black_player = Player.new('black')
    @current_player = (fen.current_player == 'w' ? white_player : black_player)
  end

  def playing
    display_board
    half_move until game_end?

    puts end_message
    play_again if yes_or_no?(:play_again)
  end

  def play_again
    Game.new(board: STARTING_POSITION).playing
  end

  def half_move
    current_player.make_move(board)
    change_player
    display_board
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
    checkmate? ? display_message(:win, player_name: current_player.name) : display_message(:draw)
  end
end
