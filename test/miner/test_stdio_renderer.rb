require "minitest/autorun"
require "miner/stdio_renderer"

class TestStdioRenderer < Minitest::Test

  def setup
    @stdioRenderer = StdioRenderer.new
  end

  def test_show_field
    field = Field.new(width: 3, height: 3, mines: 3)
    assert_output("\n  012\n  ---\n0|???\n1|???\n2|???\n") do
      @stdioRenderer.show_field(field)
    end
  end

  def test_show_lose_message
    assert_output("You lose! Bye!\n") { @stdioRenderer.show_lose_message }
  end

  def test_show_win_message
    assert_output("You win! Bye!\n") { @stdioRenderer.show_win_message }
  end

end
