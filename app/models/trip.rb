class Trip < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  def self.new_trip(start_station_id, end_station_id, start_time_raw, end_time_raw, user_id)
	ride = Ride.calculate_distance(start_station_id, end_station_id)
	user = User.find_by_id(user_id)
	start_time = DateTime.strptime(start_time_raw, '%Y-%m-%d %H:%M:%S')
	end_time = DateTime.strptime(end_time_raw, '%Y-%m-%d %H:%M:%S')

	if ride.id.nil? || user.nil? || start_time > end_time
		Trip.new
	else
		Trip.find_or_create_by(ride: ride, user: user, start_time: start_time, end_time: end_time)
	end
  end
end
