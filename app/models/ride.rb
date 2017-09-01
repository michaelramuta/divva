class Ride < ApplicationRecord
	def self.format_distance(ride, distance=nil)
		if distance.nil?
			distance = Ride.where(start_station_id: ride.start_station_id, end_station_id: ride.end_station_id).first_or_initialize.distance
		end

		{distance: distance, start_station_id: ride.start_station_id, end_station_id: ride.end_station_id}
	end
end
