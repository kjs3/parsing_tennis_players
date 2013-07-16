require_relative 'record_parser'
require_relative 'person'

class PeopleSubGroup

  attr_accessor :filename
  attr_reader :people

  def initialize(filename=nil)
    @filename = filename
    @people = filename ? read_file : []
  end

  # make sure to update people if filename is changed
  def filename=(filename)
    initialize(filename)
  end

  private

  def read_file
    people = []
    parser = RecordParser.new(filename)
    parser.rows.each do |row|
      people << Person.new(row, parser.type)
    end
    people
  rescue Exception => e
    raise e
  end

end