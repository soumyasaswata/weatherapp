require 'httparty'

class GeocodingService
  def initialize(api_key)
    @api_key = api_key
  end

  def get_lat_long_from_zipcode(country_code, zipcode)
    begin
      response = HTTParty.get("http://api.openweathermap.org/geo/1.0/zip?zip=#{zipcode},#{country_code}&appid=#{@api_key}")
      data = JSON.parse(response.body)

      puts data

      if data.key?('lat') && data['lat'] != nil  && data.key?('lon') && data['lon'] != nil
        { lat: data['lat'], long: data['lon'] }
      else
        { error: 'Location not found for the given zipcode and country code' }
      end
    rescue StandardError => e
      { error: e.message }
    end
  end
end