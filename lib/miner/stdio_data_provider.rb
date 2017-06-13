class StdioDataProvider

  def initialize(options)
    @size_range = options[:size_range]
    @min_mines = options[:min_mines]
  end

  def get_field_options
    size = get_field_size
    mines = get_mines_count(size)
    { width: size[0], height: size[1], mines: mines }
  end

  def get_field_size
    loop do
      puts "Enter field size (X Y) in range from #{@size_range.first} to #{@size_range.last}: "
      input = gets.match(/\A[0-9]+ [0-9]+\s?\z/)
      next unless input
      sizes = input[0].split(' ').map(&:to_i)
      return sizes if @size_range.include?(sizes[0]) && @size_range.include?(sizes[1])
    end
  end

  def get_mines_count(sizes)
    max_mines = (sizes[0] * sizes[1] / 3).ceil
    loop do
      puts "Enter mines count in range from #{@min_mines} to #{max_mines}: "
      input = gets.match(/\A[0-9]+\s?\z/)
      next unless input
      count = input[0].to_i
      return count if (@min_mines..max_mines).include?(count)
    end
  end

  def get_player_move(width, height)
    loop do
      puts "Your move (X Y), X in range from 0 to #{width - 1}, Y in range from 0 to #{height - 1}: "
      input = gets.match(/\A[0-9]+ [0-9]+\s?\z/)
      next unless input
      move = input[0].split(' ').map(&:to_i)
      return move if (0...width).include?(move[0]) && (0...height).include?(move[1])
    end
  end

end
