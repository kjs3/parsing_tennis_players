#
# This class takes an array of values and translates 
# it into expected values for a person record based on file type.
#

class Person

  attr_accessor :name_first, :name_last, :middle_initial, :gender, :fav_color, :date_of_birth

  def initialize(line_array=nil, type=nil)
    if line_array and type
      case type
      when 'csv' then set_attrs_for_csv(line_array)
      when 'psv' then set_attrs_for_psv(line_array)
      when 'ssv' then set_attrs_for_ssv(line_array)
      end
    end
  end

  def dob_to_i
    date = @date_of_birth.split('/')
    "#{date[2]}#{date[0]}#{date[1]}"
  end

  private

  def set_attrs_for_csv(line_array)
    # LastName, FirstName, Gender, FavoriteColor, DateOfBirth
    attr_order = %w(name_last name_first gender fav_color date_of_birth)
    line_array.each_with_index do |attribute, i| 
      self.instance_variable_set("@#{attr_order[i]}", attribute)
    end
  end
  def set_attrs_for_psv(line_array)
    # LastName | FirstName | MiddleInitial | Gender | FavoriteColor | DateOfBirth
    attr_order = %w(name_last name_first middle_initial gender fav_color date_of_birth)
    line_array.each_with_index do |attribute, i| 
      self.instance_variable_set("@#{attr_order[i]}", attribute)
    end
    set_gender
    set_date_of_birth
  end
  def set_attrs_for_ssv(line_array)
    # LastName FirstName MiddleInitial Gender DateOfBirth FavoriteColor
    attr_order = %w(name_last name_first middle_initial gender date_of_birth fav_color)
    line_array.each_with_index do |attribute, i| 
      self.instance_variable_set("@#{attr_order[i]}", attribute)
    end
    set_gender
    set_date_of_birth
  end

  def set_gender
    case @gender
    when "M" then @gender = "Male"
    when "F" then @gender = "Female"
    end
  end

  def set_date_of_birth
    @date_of_birth = @date_of_birth.gsub('-', '/')
  end

end