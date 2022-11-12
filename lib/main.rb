require_relative 'board'
require_relative 'piece'
require_relative 'bishop'
require_relative 'no_piece'
require_relative 'player'
require_relative 'game'
require_relative '../spec/board_decoder'

include BoardDecoder

# game = Game.new

# game.setup
# game.playing

board = Board.new(board: '2b2b2/8/7b/8/8/8/B7/2B2B2')

pp fen_string(board.board)