class Slot
  attr_accessor :id, :in_time, :out_time
  def initialize id, in_time, out_time

    if timeCheck in_time , out_time
      raise ArgumentError, "In-time cannot be later than out-time."
    elsif !id.is_a? Numeric
      raise ArgumentError, "Slot value must be num"
    else
      @in_time = DateTime.strptime(in_time, "%Y-%m-%d %H:%M")
      @out_time = DateTime.strptime(out_time, "%Y-%m-%d %H:%M")
      @id = id
    end

  end


  def timeCheck in_time, out_time
    in_time > out_time
  end

  def to_s
    "id: #{id}, in_time: #{in_time}, out_time: #{out_time}"
  end

end
