class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :ride, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
