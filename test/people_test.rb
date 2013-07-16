require "test/unit"
require_relative "../lib/people"

class TestPeople < Test::Unit::TestCase

  def test_initialized_people_takes_array_of_files_and_creates_sub_groups
    @people = People.new(["comma.txt", "pipe.txt", "space.txt"])
    assert @people.sub_groups.is_a? Array
    assert @people.sub_groups[0].is_a? PeopleSubGroup
  end
  def test_some_blank_files_adds_error
    @people_some_blank_files = People.new(["comma.txt", "pipe.txt", "", "space.txt", ""])
    assert @people_some_blank_files.sub_groups.is_a? Array
    assert (@people_some_blank_files.sub_groups[0].is_a? PeopleSubGroup)
    assert @people_some_blank_files.sub_groups.length == 3
    assert !@people_some_blank_files.errors.empty?
  end
  def test_some_nonexistent_files
    @people_some_bad_files = People.new(["comma.txt", "pipe.txt", "space.txt", "foo.txt", "bar.txt"])
    assert @people_some_bad_files.sub_groups.is_a? Array
    assert (@people_some_bad_files.sub_groups[0].is_a? PeopleSubGroup)
    assert @people_some_bad_files.sub_groups.length == 3
    assert !@people_some_bad_files.errors.empty?
  end
  def test_some_blank_and_nonexistent_files
    @people_some_bad_files = People.new([" ", "", "comma.txt", "", " ", "pipe.txt", "foo.txt", "space.txt"])
    assert @people_some_bad_files.sub_groups.is_a? Array
    assert (@people_some_bad_files.sub_groups[0].is_a? PeopleSubGroup)
    assert @people_some_bad_files.sub_groups.length == 3
    assert !@people_some_bad_files.errors.empty?
  end

  def test_sort_by_gender_female_then_male_then_name_ascending
    people = People.new(["comma.txt", "pipe.txt", "space.txt"])
    gender_sorted = people.by_gender
    assert_equal "Hingis", gender_sorted.first.name_last
    assert_equal "Smith", gender_sorted.last.name_last
  end

  def test_sort_by_birth_date_ascending
    people = People.new(["comma.txt", "pipe.txt", "space.txt"])
    birth_date_sorted = people.by_birth_date
    assert_equal "Abercrombie", birth_date_sorted.first.name_last, "#{birth_date_sorted.first.dob_to_i}"
    assert_equal "Smith", birth_date_sorted.last.name_last
  end

  def test_sort_by_last_name_descending
    people = People.new(["comma.txt", "pipe.txt", "space.txt"])
    last_name_sorted = people.by_last_name
    assert_equal "Smith", last_name_sorted.first.name_last
    assert_equal "Abercrombie", last_name_sorted.last.name_last
  end

end