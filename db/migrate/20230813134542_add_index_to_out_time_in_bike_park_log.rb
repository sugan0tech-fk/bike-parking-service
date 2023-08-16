class AddIndexToOutTimeInBikeParkLog < ActiveRecord::Migration[7.0]
  def change
    add_index :bike_park_logs, :out_time
  end
end
