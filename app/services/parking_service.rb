class ParkingSlot
  @capacity
  @bikes

  def initialize capacity
    if capacity < 0
      raise ArgumentError, "invalid capacity must be greater than 0"
    elsif  capacity%2 != 0
      raise ArgumentError, "invalid capacity must be even number"
    end
    @capacity = capacity
    @bikes = Array.new
  end

  # bike should be parked after validation ( with time )
  def add_bike bike, slot
    if is_valid_slot slot
      bike.add_slot slot
      @bikes << bike
    end
  end


  def show
    puts "bikes :"
    for bike in @bikes
      puts bike.to_s
    end
  end

  def is_valid_slot slot

    if slot.id == nil
      false
    end

    if slot.id > @capacity || slot.id < @capacity
      false
    end

    response = true
    for bike in @bikes
      curr_slot = bike.slots[slot.id]
      if curr_slot
        response = (slot.in_time > curr_slot.out_time || slot.out_time < curr_slot.in_time)  && response
      end
    end
    response
  end

  private :is_valid_slot
end
