class CreateBikeParkLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :bike_park_logs do |t|
      t.integer :slot_no
      t.string :bike
      t.datetime :in_time
      t.datetime :out_time

      t.timestamps
    end
  end
end
