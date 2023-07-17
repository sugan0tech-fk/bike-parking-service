class Slot
  attr_accessor :id, :in_time, :out_time
  def initialize id, in_time, out_time
    if in_time > out_time
      raise ArgumentError, "In-time cannot be later than out-time."
    end
    @id = id
    @in_time = in_time
    @out_time = out_time
  end


  def timeCheck in_time, out_time
    in_time < out_time
  end

  def to_s
    "id: #{id}, in_time: #{in_time}, out_time: #{out_time}"
  end

end
