class Slot
  attr_accessor :id, :in_time, :out_time
  def initialize id, in_time, out_time

    if timeCheck in_time , out_time
      raise ArgumentError, "In-time cannot be later than out-time."
    else
      @in_time = DateTime.strptime(in_time, "%Y-%m-%d %H:%M")
      @out_time = DateTime.strptime(out_time, "%Y-%m-%d %H:%M")
      @id = id
    end

  end


  def timeCheck in_time, out_time

    # regex = /\A\d{4}-\d{2}-\d{2}\s\d\d{2}:\d{2}\z/

    # puts in_time.match?(regex) || out_time.match?(regex)

    DateTime.strptime(in_time, "%Y-%m-%d %H:%M") > DateTime.strptime(out_time, "%Y-%m-%d %H:%M")
  end

  def to_s
    "id: #{id}, in_time: #{in_time}, out_time: #{out_time}"
  end

end
