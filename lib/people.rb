require_relative 'people_sub_group'

class People

  attr_reader :people, :sub_groups, :errors

  def initialize(files=[])
    @errors = []
    @sub_groups = []
    @people = []
    generate_sub_groups(files)
    generate_people
  end

  def by_gender
    @people.sort{|a,b| [a.gender, a.name_last] <=> [b.gender, b.name_last]}
  end

  def by_birth_date
    @people.sort{|a,b| [a.dob_to_i, a.name_last] <=> [b.dob_to_i, b.name_last]}
  end

  def by_last_name
    @people.sort{|a,b| a.name_last <=> b.name_last}.reverse
  end

  def print
    puts "Output 1:"
    by_gender.each {|p| format(p)}

    puts "\nOutput 2:"
    by_birth_date.each {|p| format(p)}

    puts "\nOutput 3:"
    by_last_name.each {|p| format(p)}
  end

  private

  def format(p)
    puts "#{p.name_last} #{p.name_first} #{p.gender} #{p.date_of_birth} #{p.fav_color}"
  end

  def generate_sub_groups(files)
    # rescue error and retry for as many files as there are
    # but don't allow an infinite loop
    error_retries = files.length

    files.each do |f|
      begin
        sub_group = PeopleSubGroup.new(f)
        @sub_groups << sub_group
      rescue Exception => e
        if error_retries > 0
          error_retries -= 1
          @errors << e
          next
        else
          raise e
        end
      end
    end
  end

  def generate_people
    @sub_groups.each do |sub_group|
      sub_group.people.each { |person| @people << person }
    end
  end

end