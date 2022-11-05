require_relative 'board'
require_relative 'piece'
require_relative 'bishop'
require_relative 'player'
require_relative 'game'

board = Board.new

board.set_piece(' ♝ ', 'd4')
board.print_board

board.move_piece('d4', 'a1')
board.print_board
