class ParkingSlot
  @capacity
  @bikes
  @max_frequnecies

  def initialize capacity
    if !capacity.is_a? Numeric
      raise ArgumentError, "#{capacity} is not valid capacity"
    elsif capacity <= 0
      raise ArgumentError, "invalid capacity must be greater than 0"
    elsif capacity > 1000
      raise ArgumentError, "capacity must be less than or equal to 1000"
    elsif  capacity%2 != 0
      raise ArgumentError, "invalid capacity must be even number"
    end
    @capacity = capacity
    @bikes = Array.new
  end

  def load_bikes bikes, slots, in_time, out_time

    count_check = bikes.length

    if (count_check != slots.length) || (count_check != slots.length) || (count_check != in_time.length) || (count_check != out_time.length)
      raise ArgumentError, "Array size mismatch"
    end
    bikes.length.times do |i|
      begin
        if !slots[i].is_a? Numeric
          raise ArgumentError, "Slot value must be num"
        elsif(slots[i] < 0 || slots[i] > @capacity)
          raise ArgumentError, "Invalid slot value #{slots[i]}"
        end
        slot = Slot.new slots[i], in_time[i], out_time[i]
        bike = Bike.new bikes[i]
        self.add_bike bike, slot
      rescue ArgumentError => e
        puts e.message + "\n skipping it"
        e.message
      end
    end
  end

  def add_one_bike bike, slot, in_time, out_time
    begin
      if !slot.is_a? Numeric
        raise ArgumentError, "Slot value must be num"
      elsif(slot < 0 || slot > @capacity)
        raise ArgumentError, "Invalid slot value #{slot}"
      end
      slot = Slot.new slot, in_time, out_time
      bike = Bike.new bike
      self.add_bike bike, slot
    rescue ArgumentError => e
      puts e.message + "\n skipping it"
      e.message
    end
  end

  def get_load
    @bikes
  end

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

  def get_max_frequency
    @max_frequnecies
  end


  private :is_valid_slot
end
