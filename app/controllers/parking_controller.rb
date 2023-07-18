require_relative "../services/parking_service"
require_relative "../services/bike_schema"
require_relative "../services/slot_schema"
class ParkingController < ApplicationController
  @max_frequnecy
  @max_time
  @parking_slot

  def load_data
    capacity = params[:capacity]
    bikes = params[:bikes]
    slots = params[:slots]
    in_time = params[:in_time]
    out_time = params[:out_time]


    @parking_slot = ParkingSlot.new capacity
    @parking_slot.load_bikes bikes, slots, in_time, out_time

    render json: @parking_slot.get_load
  end

  def max_frequnecy
    if @max_frequnecy.nil?
      render json: "Details haven't be provided"
    else
      render json: "<p>Max Frequency</p>"
    end
  end

  def max_time
    if @max_frequnecy.nil?
      render json: "Details haven't be provided"
    else
      render json: "<p>max Time</p>"
    end
  end
end
