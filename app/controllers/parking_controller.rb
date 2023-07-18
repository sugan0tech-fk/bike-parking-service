require_relative "../services/parking_service"
require_relative "../services/bike_schema"
require_relative "../services/slot_schema"
class ParkingController < ApplicationController
  $max_frequnecy
  $max_time
  $parking_slot
  $lock = false

  def load_data
    if $lock
      render json: "locked"
      return
    end
    capacity = params[:capacity]
    bikes = params[:bikes]
    slots = params[:slots]
    in_time = params[:in_time]
    out_time = params[:out_time]


    $parking_slot = ParkingSlot.new capacity
    $parking_slot.load_bikes bikes, slots, in_time, out_time
    $max_frequnecy = $parking_slot.get_max_frequency

    render json: $parking_slot.get_load
  end

  def add_data
    if $lock
      render json: "locked"
      return
    end
    bike = params[:bike]
    slot = params[:slot]
    in_time = params[:in_time]
    out_time = params[:out_time]

    $parking_slot.add_one_bike bike, slot, in_time, out_time

  end

  def max_frequnecy
    if $lock
      render json: "locked"
      return
    end
    if $max_frequnecy.nil?
      render json: "Details haven't be provided"
    else
      render json: "<p>Max Frequency</p>"
    end
  end

  def max_time
    if $lock
      render json: "locked"
      return
    end
    if $max_frequnecy.nil?
      render json: "Details haven't be provided"
    else
      render json: "<p>max Time</p>"
    end
  end

  def set_lock
    $lock = !$lock
  end
end
