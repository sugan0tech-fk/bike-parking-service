class CreateMaxFrequencies < ActiveRecord::Migration[7.0]
  def change
    add_index :max_frequencies, [:bike_one, :bike_two]
  end
end
