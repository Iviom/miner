class Field
  GAME_CONTINUE = :game_continue
  GAME_WON = :game_won
  GAME_LOST = :game_lost

  attr_reader :width, :height, :total_mines, :visible_cells,
    :nearby_mines, :turn, :mines

  def initialize(options)
    @nearby_mines = Array.new(options[:height]) { Array.new(options[:width]).fill(0) }
    @visible_cells = Array.new(options[:height]) { Array.new(options[:width]).fill(false) }
    @width = options[:width]
    @height = options[:height]
    @total_mines = options[:mines]
    @mines = []
    @turn = 0
  end

  def make_move(player_move)
    if @turn == 0
      place_mines(player_move)
    elsif cell_mined?(player_move)
      reveal_all_cells
      return GAME_LOST
    end
    reveal_cell(player_move)
    if all_cells_revealed?
      reveal_all_cells
      return GAME_WON
    end
    @turn += 1
    return GAME_CONTINUE
  end

  def cell_mined?(cell)
    @mines.include?(cell)
  end

  protected

  def reveal_cell(player_move)
    @visible_cells[player_move[1]][player_move[0]] = true
    if cell_mined?(player_move)
      @visible_cells = Array.new(@height) { Array.new(@width).fill(true) }
    else
      reveal_neighbours(player_move)
    end
  end

  def all_cells_revealed?
    @visible_cells.flatten.count(true) + @mines.count == width * height
  end

  def place_mines(first_move)
    while(@mines.count < @total_mines) do
      new_mine = [rand(@width), rand(@height)]
      unless @mines.include?(new_mine) || new_mine == first_move
        @mines << new_mine
        increase_nearby_mines_count(new_mine)
      end
    end
  end

  def increase_nearby_mines_count(coords)
    neighbour_cells(coords) do |x, y|
      @nearby_mines[y][x] += 1
    end
  end

  def neighbour_cells(coords)
    left   = [coords[0] - 1, 0].max
    top    = [coords[1] - 1, 0].max
    right  = [coords[0] + 1, @width - 1].min
    bottom = [coords[1] + 1, @height - 1].min

    for y in top..bottom
      for x in left..right
        next if coords == [x, y]
        yield(x, y)
      end
    end
  end

  def reveal_neighbours(coords)
    neighbour_cells(coords) do |x, y|
      next if @visible_cells[y][x] == true || cell_mined?([x, y])
      @visible_cells[y][x] = true
      reveal_neighbours([x, y]) if @nearby_mines[y][x] == 0
    end
  end

  def reveal_all_cells
    @visible_cells = Array.new(@height) { Array.new(@width).fill(true) }
  end

end
