require 'net/http'
require 'json'

class Ride < ApplicationRecord

	def self.calculate_ride(ride)
		start_station = Station.find_by(station_id: ride.start_station_id)
		end_station = Station.find_by(station_id: ride.end_station_id)

		if !start_station.nil? && !end_station.nil?
			base_url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
			location_parameters = '?origins=' + start_station.lat.to_s + ',' + start_station.lon.to_s + '&destinations=' + end_station.lat.to_s + ',' + end_station.lon.to_s
			additional_params = '&mode=bicyclingkey&units=imperial&key=' + ENV['GOOGLE_MAPS_KEY']
			uri = URI(base_url + location_parameters + additional_params)
			response = Net::HTTP.get(uri)
			result = JSON.parse(response)

			if result['status'] == 'OK'
				result['rows'].each_with_index do |row,i|
					row['elements'].each do |element,j|
						ride.distance = element['distance']['value'].to_f
						ride.save
					end
				end
			end
		end

		ride
	end

	def self.calculate_distance(start_station_id, end_station_id)
		ride = Ride.where(start_station_id: start_station_id, end_station_id: end_station_id).first_or_initialize
		ride.distance.nil? ? Ride.calculate_ride(ride) : ride
	end
end
