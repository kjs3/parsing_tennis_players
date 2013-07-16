require "test/unit"
require_relative "../lib/record_parser"

class TestRecordParser < Test::Unit::TestCase
  def setup
    @file_comma = RecordParser.new("comma.txt")
    @file_pipe = RecordParser.new("pipe.txt")
    @file_space = RecordParser.new("space.txt")
  end

  def test_comma_record_initialized
    assert @file_comma
    assert_equal 'comma.txt', @file_comma.filename
    assert_equal 'csv', @file_comma.type
  end
  def test_pipe_record_initialized
    assert @file_pipe
    assert_equal 'pipe.txt', @file_pipe.filename
    assert_equal 'psv', @file_pipe.type
  end
  def test_space_record_initialized
    assert @file_space
    assert_equal 'space.txt', @file_space.filename
    assert_equal 'ssv', @file_space.type
  end
  def test_user_defined_csv
    file = RecordParser.new('pipe.txt', 'csv')
    assert_equal 'csv', file.type
  end
  def test_user_defined_psv
    file = RecordParser.new('space.txt', 'psv')
    assert_equal 'psv', file.type
  end
  def test_user_defined_ssv
    file = RecordParser.new('comma.txt', 'ssv')
    assert_equal 'ssv', file.type
  end
  def test_error_raised_on_incorrect_type
    exception = assert_raises(RuntimeError) { RecordParser.new("comma.txt", "bar") }
    assert_equal "type argument needs to be 'csv', 'psv', or 'ssv'", exception.message
  end
  def test_file_error_raised_with_bad_file
    exception = assert_raises(RuntimeError) { RecordParser.new("foo.txt") }
    assert_equal "There was an error reading file: foo.txt", exception.message
  end
  def test_file_error_raised_with_blank_filename
    exception = assert_raises(RuntimeError) { RecordParser.new("") }
    assert_equal "There was an error reading file: ", exception.message
  end

  def test_comma_rows_returns_array_of_arrays
    assert (@file_comma.rows.is_a? Array)
    assert (@file_comma.rows[0].is_a? Array)
  end
  def test_pipe_rows_returns_array_of_arrays
    assert (@file_pipe.rows.is_a? Array)
    assert (@file_pipe.rows[0].is_a? Array)
  end
  def test_space_rows_returns_array_of_arrays
    assert (@file_space.rows.is_a? Array)
    assert (@file_space.rows[0].is_a? Array)
  end

  def test_row_content_csv
    # expected output from parser
    attrs_array = ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
    assert_equal attrs_array, @file_comma.rows[0]
  end
  def test_row_content_psv
    attrs_array = ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]
    assert_equal attrs_array, @file_pipe.rows[0]
  end
  def test_row_content_ssv
    attrs_array = ["Kournikova", "Anna", "F", "F", "6-3-1975", "Red"]
    assert_equal attrs_array, @file_space.rows[0]
  end

end