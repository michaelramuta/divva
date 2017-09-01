class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.integer :start_station_id
      t.integer :end_station_id
      t.float :distance

      t.timestamps
    end
  end
end
