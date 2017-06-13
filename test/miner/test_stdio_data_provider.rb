require "minitest/autorun"
require "miner/stdio_data_provider"

class TestStdioDataProvider < Minitest::Test

  def setup
    @stdio_data_provider = StdioDataProvider.new(size_range: 3..9, min_mines: 1)
  end

  def test_get_field_options
    stub_stdin("4 3\n1\n") do
      options = { width: 4, height: 3, mines: 1 }
      assert_equal options, @stdio_data_provider.get_field_options
    end
  end

  def test_get_player_move
    stub_stdin("1 1\n") do
      output = "Your move (X Y), X in range from 0 to 2, Y in range from 0 to 2: \n"
      assert_output(output) { @stdio_data_provider.get_player_move(3, 3) }
    end
    stub_stdin("1 1\n") do
      assert_equal [1, 1], @stdio_data_provider.get_player_move(3, 3)
    end
    stub_stdin("a\nb1 3\n4\n5 5\n-1 0\n2 1\n") do
      assert_equal [2, 1], @stdio_data_provider.get_player_move(3, 3)
    end
  end

  def test_get_field_size
    stub_stdin("3 4\n") do
      output = "Enter field size (X Y) in range from 3 to 9: \n"
      assert_output(output) { @stdio_data_provider.get_field_size }
    end
    stub_stdin("3 4\n") do
      assert_equal [3, 4], @stdio_data_provider.get_field_size
    end
    stub_stdin("1 2\na\na 6\n4 3\n") do
      assert_equal [4, 3], @stdio_data_provider.get_field_size
    end
  end

  def test_get_mines_count
    stub_stdin("1\n") do
      output = "Enter mines count in range from 1 to 4: \n"
      assert_output(output) { @stdio_data_provider.get_mines_count([3, 4]) }
    end
    stub_stdin("1\n") do
      assert_equal 1, @stdio_data_provider.get_mines_count([3, 4])
    end
    stub_stdin("0\na1\nb\n4\n3\n") do
      assert_equal 4, @stdio_data_provider.get_mines_count([3, 4])
    end
  end

  protected

  def stub_stdin(input)
    $stdin = StringIO.new(input)
    $stdout = StringIO.new # suppress output from tested code
    yield
  ensure
    $stdin = STDIN
    $stdout = STDOUT
  end

end
