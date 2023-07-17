class Vehicle
  attr_accessor :id , :slots
  @slots

  def initialize id
    @id = id
    @slots = Hash.new
  end

  def add_slot slot
    @slots[slot.id] = slot
  end

  def to_s
    "id: #{id} slots: #{slots}"
  end


end
