require_relative 'lib/miner'

Miner.new(size_range: 3..9, min_mines: 1).play
