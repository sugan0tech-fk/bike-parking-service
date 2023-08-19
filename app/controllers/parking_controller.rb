require_relative '../services/parking_service'
require_relative '../services/bike_schema'
require_relative '../services/slot_schema'
class ParkingController < ApplicationController
  $lock = false

  def load_data
    if $lock
      render json: 'locked'
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
      render json: 'locked'
      return
    end
    bike = params[:bike]
    slot = params[:slot]
    in_time = params[:in_time]
    out_time = params[:out_time]

    data = $parking_slot.add_one_bike bike, slot, in_time, out_time
    render json: data
  end

  def max_frequnecy
    if $lock
      render json: 'locked'
      return
    end
    results = $parking_slot.get_max_time

    if results.nil?
      render json: "Details haven't be provided"
    else
      render json: results.sort_by { |_bike, stats| -stats[:occurrences] }
    end
    nil
  end

  def max_time
    if $lock
      render json: 'locked'
      return
    end
    results = $parking_slot.get_max_time

    if results.nil?
      render json: "Details haven't be provided"
    else
      render json: results.sort_by { |_bike, stats| -stats[:overlapping_time] }
    end
    nil
  end

  def set_lock
    $lock = !$lock
    render json: $lock
  end
end
