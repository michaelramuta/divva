class TripsController < ApplicationController

	def index
		# start_station_id = params[:start_station_id]
		# end_station_id = params[:end_station_id]
		start_station_id = 5
		end_station_id = 41
		start_time_raw = '2017-08-01 08:27:01'
		end_time_raw = '2017-08-01 08:52:47'
		user_id = 1

		@response = Trip.new_trip(start_station_id, end_station_id, start_time_raw, end_time_raw, user_id)
	end
end