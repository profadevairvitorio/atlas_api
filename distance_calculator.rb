require 'sinatra'
require 'json'

def haversine(lat1, lon1, lat2, lon2)
  # Convert degrees to radians
  lat1, lon1, lat2, lon2 = [lat1, lon1, lat2, lon2].map { |coord| coord * Math::PI / 180.0 }

  # Haversine formula
  dlat = lat2 - lat1
  dlon = lon2 - lon1
  a = Math.sin(dlat / 2)**2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon / 2)**2
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

  # Earth radius in kilometers (you can adjust this value)
  radius = 6371.0

  # Calculate distance
  distance = radius * c

  return distance.round(2)
end

get '/distance' do
  content_type :json

  # Get latitude and longitude parameters from the query string
  lat1 = params['lat1'].to_f
  lon1 = params['lon1'].to_f
  lat2 = params['lat2'].to_f
  lon2 = params['lon2'].to_f

  # Calculate distance using Haversine formula
  distance = haversine(lat1, lon1, lat2, lon2)

  # Return the result as JSON
  { distance: "#{distance} m " }.to_json
end

