require 'weather_forecast_service'

class Api::V1::WeatherForecastsController < ApplicationController
  def get_forecast
    weather_forecast_service = WeatherForecastService.new(WEATHER_API_KEY)

    begin
      @weather_data = weather_forecast_service.fetch_weather_forecast(params[:country_code], params[:zipcode])

      if @weather_data.key?(:error)
        render json: { error: @weather_data[:error] }, status: :unprocessable_entity
      else
        render json: @weather_data
      end
    rescue CustomExceptions::LocationNotFoundError => e
      render json: { error: e.message }, status: :not_found
    rescue CustomExceptions::InvalidInputError => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue StandardError => e
      puts "abc"
      render json: { error: "Error fetching weather data: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
