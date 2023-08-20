class ParkingSlot
  def initialize(capacity)
    if !capacity.is_a? Numeric
      raise ArgumentError, "#{capacity} is not valid capacity"
    elsif capacity <= 0
      raise ArgumentError, 'invalid capacity must be greater than 0'
    elsif capacity > 1000
      raise ArgumentError, 'capacity must be less than or equal to 1000'
    elsif capacity.odd?
      raise ArgumentError, 'invalid capacity must be even number'
    end

    @capacity = capacity
    @bikes = []
    @bike_pairs = {}
  end

  def insert_db(bike, slot)
    # if BikeParkLog.where("slot_no = ? AND ((in_time, out_time) OVERLAPS (?, ?))", slot.id, slot.in_time,slot.out_time).exists?
    # for postgress
    unless BikeParkLog.where('slot_no = ? AND ((in_time <= ? AND out_time >= ?) OR (out_time >= ? AND in_time <= ?))',
                             slot.id, slot.out_time, slot.in_time, slot.in_time, slot.out_time).exists?
      Rails.logger.info 'inside--------'
      BikeParkLog.create bike: bike.id, slot_no: slot.id, in_time: slot.in_time, out_time: slot.out_time
    end
  end

  def load_bikes(bikes, slots, in_time, out_time)
    count_check = bikes.length

    if (count_check != slots.length) || (count_check != slots.length) || (count_check != in_time.length) || (count_check != out_time.length)
      raise ArgumentError, 'Array size mismatch'
    end

    # validators
    bikes.length.times do |i|
      if !slots[i].is_a? Numeric
        raise ArgumentError, 'Slot value must be num'
      elsif slots[i] < 0 || slots[i] > @capacity
        raise ArgumentError, "Invalid slot value #{slots[i]}"
      end

      slot = Slot.new slots[i], in_time[i], out_time[i]
      bike = Bike.new bikes[i]
      insert_db bike, slot
    rescue ArgumentError => e
      puts e.message + "\n skipping it"
      e.message
    end
  end

  def add_one_bike(bike, slot, in_time, out_time)
    if !slot.is_a? Numeric
      raise ArgumentError, 'Slot value must be num'
    elsif slot < 0 || slot > @capacity
      raise ArgumentError, "Invalid slot value #{slot}"
    end

    slot = Slot.new slot, in_time, out_time
    bike = Bike.new bike
    add_bike bike, slot
    insert_db bike, slot
  rescue ArgumentError => e
    puts e.message + "\n skipping it"
    e.message
  end

  def get_load
    @bikes
  end

  def add_bike(bike, slot)
    return unless is_valid_slot slot

    bike.add_slot slot
    @bikes << bike
  end

  def show
    puts 'bikes :'
    for bike in @bikes
      puts bike
    end
  end

  def is_valid_slot(slot)
    false if slot.id.nil?

    false if slot.id > @capacity || slot.id < @capacity

    response = true
    for bike in @bikes
      curr_slot = bike.slots[slot.id]
      response = (slot.in_time > curr_slot.out_time || slot.out_time < curr_slot.in_time) && response if curr_slot
    end
    response
  end

  def get_max_frequency
    @max_frequnecies
  end

  def get_max_time
    bike_pairs = {}
    parking_data = BikeParkLog.order(:slot_no, :in_time)

    grouped_data = parking_data.group_by { |bike| bike.slot_no }

    puts grouped_data
    grouped_data.each do |_slot_no, bikes_in_slot|
      bikes_in_slot.each do |bike|
        pair_slots = [bike.slot_no + 1, bike.slot_no + @capacity / 2] # skipping slot_no - 1 bike since moving from slot 1 ASC

        pair_slots.each do |pair_slot|
          next unless grouped_data[pair_slot]

          grouped_data[pair_slot].each do |adj_bike|
            pair_key = [bike.bike, adj_bike.bike].sort
            overlapping_time = [0, [bike.out_time, adj_bike.out_time].min - [bike.in_time, adj_bike.in_time].max].max
            if overlapping_time.zero?
              next
            elsif bike_pairs[pair_key].nil?
              bike_pairs[pair_key] = { overlapping_time: overlapping_time, occurrences: 1 }
            else
              bike_pairs[pair_key][:overlapping_time] += overlapping_time
              bike_pairs[pair_key][:occurrences] += 1
            end
          end
        end
      end
    end

    bike_pairs
  end

  private :is_valid_slot
end
