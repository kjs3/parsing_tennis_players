class RecordParser

  attr_reader :filename, :type

  def initialize(filename, type=nil)
    @filename = filename

    # set type or take parameter
    case type
    when nil then @type = set_type
    when 'csv' then @type = type
    when 'psv' then @type = type
    when 'ssv' then @type = type
    else
      raise "type argument needs to be 'csv', 'psv', or 'ssv'"
    end
  end

  def rows
    data = []
    # run through each row in the file returning an array of values
    File.open(@filename, "r").each_line do |line|
      # data << (@type == "csv" ? parse_csv_row(line) : parse_psv_row(line))
      data << send("parse_#{@type}", line)
    end
    # return the array of arrays
    data
  rescue
    set_file_error
  end

  private

  def set_type
    types = Hash.new(0)
    # read each line of the file and add up commas, pipes, and spaces
    File.open(@filename, "r").each_line do |line|
      types["csv"] += line.scan(/, /).size
      types["psv"] += line.scan(/ \| /).size
      types["ssv"] += line.scan(/\w \w/).size
    end
    # whichever is greater is considered the type
    # this is obviously not bulletproof
    return types.max_by{|k,v| v}[0]
  rescue Exception => e
    set_file_error
  end

  def parse_csv(line)
    line.split(", ").each {|s| s.strip!}
  end
  def parse_psv(line)
    line.split(" | ").each {|s| s.strip!}
  end
  def parse_ssv(line)
    line.split(" ").each {|s| s.strip!}
  end

  def set_file_error
    raise "There was an error reading file: #{@filename}"
  end

end