require "minitest/autorun"
require 'minitest/stub_any_instance'
require "miner/field"

class TestField < Minitest::Test

  def test_make_move
    field = Field.new(width: 3, height: 3, mines: 3)
    assert_equal :game_won, field.make_move([1, 1])

    field = Field.new(width: 3, height: 3, mines: 5)
    assert_equal :game_continue, field.make_move([0, 0])
    Field.stub_any_instance 'cell_mined?', true do
      assert_equal :game_lost, field.make_move([1, 0])
    end
  end

  def test_cell_mined?
    field = Field.new(width: 3, height: 3, mines: 8)
    assert_equal :game_won, field.make_move([1, 1])
    assert field.cell_mined?([0, 0])
  end

end
