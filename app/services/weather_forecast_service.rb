require 'httparty'
require 'redis'

class WeatherForecastService
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_weather_forecast(country_code, zipcode)
    begin
      cache_key = cache_key_for(country_code, zipcode)
      cached_weather_data = fetch_cached_weather_data(cache_key)
      return cached_weather_data if cached_weather_data.present?

      location_data = GeocodingService.new(@api_key).get_lat_long_from_zipcode(country_code, zipcode)
      return { error: 'Error fetching location data' } if location_data.key?(:error)

      lat = location_data[:lat]
      lon = location_data[:long]

      weather_data = fetch_weather_data(lat, lon)

      if weather_data["cod"] == 200
        cache_weather_data(cache_key, weather_data)
        weather_data
      else
        { error: "Error fetching weather data" }
      end
    rescue StandardError => e
      Rails.logger.error "Error fetching weather data: #{e.message}"
      nil
    end
  end

  private

  def cache_key_for(country_code, zipcode)
    "weather_forecast_#{country_code}_#{zipcode}"
  end

  def fetch_cached_weather_data(cache_key)
    cached_data = Redis.current.get(cache_key)
    if cached_data.present?
      Rails.logger.info "Pulled weather data from cache"
    end
    JSON.parse(cached_data) if cached_data.present?
  end

  def fetch_weather_data(lat, lon)
    begin
      response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@api_key}")
      JSON.parse(response.body)
    rescue StandardError => e
      { error: "Error fetching weather data: #{e.message}" }
    end
  end

  def cache_weather_data(cache_key, weather_data)
    Redis.current.setex(cache_key, 30.minutes.to_i, weather_data.to_json)
  end
end
