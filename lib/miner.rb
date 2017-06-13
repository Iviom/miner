require_relative 'miner/field'

class Miner
  VERSION = "1.0.0"

  def initialize(view = :stdio, options)
    require_relative "miner/#{view}_data_provider"
    @data_provider = Object.const_get(view.to_s.capitalize + 'DataProvider').new(options)

    require_relative "miner/#{view}_renderer"
    @renderer = Object.const_get(view.to_s.capitalize + 'Renderer').new
  end

  def play
    field = Field.new(@data_provider.get_field_options)
    loop do
      @renderer.show_field(field)
      player_move = @data_provider.get_player_move(field.width, field.height)
      move_result = field.make_move(player_move)
      unless move_result == Field::GAME_CONTINUE
        @renderer.show_field(field)
        @renderer.show_win_message  if move_result == Field::GAME_WON
        @renderer.show_lose_message if move_result == Field::GAME_LOST
        break
      end
    end
  end

end
