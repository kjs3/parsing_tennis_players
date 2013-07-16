require "test/unit"
require_relative "../lib/person"

class TestPerson < Test::Unit::TestCase

  def test_initialized_empty_person
    @person = Person.new()
    assert_nil @person.name_last
    assert_nil @person.name_first
    assert_nil @person.middle_initial
    assert_nil @person.gender
    assert_nil @person.fav_color
    assert_nil @person.date_of_birth
  end

  def test_initialize_attrs_for_csv

    # expected output from parser
    attrs_array = ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]

    @person = Person.new(attrs_array, "csv")

    assert_equal "Abercrombie", @person.name_last, "last name is wrong"
    assert_equal "Neil", @person.name_first, "first name is wrong"
    assert_nil @person.middle_initial, "middle_initial is not nil"
    assert_equal "Male", @person.gender, "gender is wrong <- Don't ever say to someone!"
    assert_equal "Tan", @person.fav_color, "fav_color is wrong"
    assert_equal "2/13/1943", @person.date_of_birth, "dob is wrong"
  end

  def test_initialize_attrs_for_psv

    # expected output from parser
    attrs_array = ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]

    @person = Person.new(attrs_array, "psv")

    assert_equal "Smith", @person.name_last, "last name is wrong"
    assert_equal "Steve", @person.name_first, "first name is wrong"
    assert_equal "D", @person.middle_initial, "middle_initial is wrong"
    assert_equal "Male", @person.gender, "gender is wrong"
    assert_equal "Red", @person.fav_color, "fav_color is wrong"
    assert_equal "3/3/1985", @person.date_of_birth, "dob is wrong"
  end

  def test_initialize_attrs_for_ssv

    # expected output from parser
    attrs_array = ["Kournikova", "Anna", "F", "F", "6-3-1975", "Red"]

    @person = Person.new(attrs_array, "ssv")

    assert_equal "Kournikova", @person.name_last, "last name is wrong"
    assert_equal "Anna", @person.name_first, "first name is wrong"
    assert_equal "F", @person.middle_initial, "middle_initial is wrong"
    assert_equal "Female", @person.gender, "gender is wrong"
    assert_equal "Red", @person.fav_color, "fav_color is wrong"
    assert_equal "6/3/1975", @person.date_of_birth, "dob is wrong"
  end
end