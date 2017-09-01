class RidesController < ApplicationController

	def index
		station_ids = params[:station_ids]

		if station_ids.nil?
			@response = 'why?'
		else
			station_pairs = station_ids.split('|').uniq.map{|e| e.split(',') }

			# first pass, make ride object or return distance
			rides_distance = station_pairs.map do |station_pair|
				Ride.calculate_distance(station_pair[0], station_pair[1])
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
