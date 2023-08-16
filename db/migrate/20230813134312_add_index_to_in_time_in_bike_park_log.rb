class AddIndexToInTimeInBikeParkLog < ActiveRecord::Migration[7.0]
  def change
    add_index :bike_park_logs, :in_time
  end
end
