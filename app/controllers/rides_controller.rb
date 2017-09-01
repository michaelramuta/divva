class RidesController < ApplicationController

	def index
		station_ids = params[:station_ids]

		if station_ids.nil?
			@response = 'why?'
		else
			station_pairs = station_ids.split('|').uniq.map{|e| e.split(',') }

			# first pass, make ride object or return distance
			rides = station_pairs.map do |station_pair|
				ride = Ride.where(start_station_id: station_pair[0], end_station_id: station_pair[1]).first_or_initialize
				ride.distance.nil? ? ride : Ride.format_distance(ride, ride.distance)
			end

			uncalculated_rides = rides.select{ |ride| ride.is_a?(Ride) }
			
			# calculate all unknown rides
			uncalculated_rides.each do |ride|
				Ride.calculate_ride(ride)
			end

			# map out all rides
			rides_distance = rides.map do |ride|
				if ride.is_a?(Ride)
					Ride.format_distance(ride)
				else
					ride
				end
			end

			@response = rides_distance
		end
	end

	# def main
	# 	about = 'Include Divvy station ids as pipe separated pairs to get distance in meters'
	# 	example_explanation = 'The following URL will return distances between Divvy stations 1 to 2, 3 to 4, and 5 to 6'
	# 	example = 'https://divva-api.herokuapp.com/rides?station_ids=1,2|3,4|5,6'
	# 	json_response({about: about, example: [example_explanation, example]})
	# end
end
