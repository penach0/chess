require_relative 'board'
require_relative 'piece'
require_relative 'bishop'
require_relative 'player'

board = Board.new

board.print_board

player1 = Player.new('black')

player1.place_pieces(board)

board.print_board
