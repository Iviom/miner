class StdioRenderer
  HIDDEN_CELL = '?'
  MINED_CELL = '*'

  def show_field(field)
    result =  "\n  " + (0...field.width).to_a.join
    result += "\n  " + '-' * field.width + "\n"
    for y in 0...field.height
      result += "#{y}|"
      for x in 0...field.width
        cell_mark = HIDDEN_CELL
        if field.visible_cells[y][x]
          cell_mark = field.cell_mined?([x, y]) ? MINED_CELL : field.nearby_mines[y][x]
        end
        result += cell_mark.to_s
      end
      result += "\n"
    end
    puts result
  end

  def show_lose_message
    puts 'You lose! Bye!'
  end

  def show_win_message
    puts 'You win! Bye!'
  end

end
