require "test/unit"
require_relative "../lib/people_sub_group"

class TestPeopleSubGroup < Test::Unit::TestCase
  def setup
    @people_comma = PeopleSubGroup.new("comma.txt")
    @people_pipe = PeopleSubGroup.new("pipe.txt")
    @people_space = PeopleSubGroup.new("space.txt")
  end

  def test_initialized_invoice_with_filename
    assert @people_comma.filename
    assert @people_comma.people
    assert @people_pipe.filename
    assert @people_pipe.people
    assert @people_space.filename
    assert @people_space.people
  end
  def test_blank_filename_raises_error
    exception = assert_raises(RuntimeError) { PeopleSubGroup.new("") }
    assert_equal "There was an error reading file: ", exception.message
  end
  def test_missing_file_raises_error
    exception = assert_raises(RuntimeError) { PeopleSubGroup.new("foo.txt") }
    assert_equal "There was an error reading file: foo.txt", exception.message
  end

  def test_attrs_got_set
    assert !@people_comma.people.empty?
    assert @people_comma.people[0].is_a? Person
    assert_equal "Abercrombie", @people_comma.people[0].name_last
  end
  def test_filename_changed_changes_attrs
    orig_person = @people_comma.people[0]
    @people_comma.filename = "pipe.txt"
    assert orig_person != @people_comma.people[0]
  end
end