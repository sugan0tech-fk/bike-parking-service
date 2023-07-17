class ParkingController < ApplicationController
  def load_data
    capacity = params[:capacity]
    bikes = params[:bikes]
    slots = params[:slots]
    in_time = params[:in_time]
    out_tie = params[:out_time]

    render json: "<p>Enry </p>"
  end

  def max_frequnecy
    render json: "<p>Max Frequency</p>"
  end

  def max_time
    render json: "<p>max Time</p>"
  end
end
