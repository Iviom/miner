require "minitest/autorun"
require 'minitest/stub_any_instance'
require "miner"

class TestMiner < Minitest::Test

  def setup
    @miner = Miner.new(size_range: 3..9, min_mines: 1)
  end

  def test_play
    stub_stdin("3 3\n3\n1 1\n") do
      assert_output(/.+You win! Bye!\n$/m) { @miner.play }
    end
  end

  protected

  def stub_stdin(input)
    $stdin = StringIO.new(input)
    yield
  ensure
    $stdin = STDIN
  end

end
