require_relative 'board'

board = Board.new

board.board.each do |line|
  puts line.join
end