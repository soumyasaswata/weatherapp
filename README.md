# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* Curl request
* curl --location 'http://0.0.0.0:3000/api/v1/weather_forecasts/get_forecast?country_code=GB&zipcode=E14'
  * 
    Processing by Api::V1::WeatherForecastsController#get_forecast as */*
    Parameters: {"country_code"=>"GB", "zipcode"=>"E14"}
    Completed 200 OK in 2076ms (Views: 5.9ms | ActiveRecord: 0.0ms)
  * Started GET "/api/v1/weather_forecasts/get_forecast?country_code=GB&zipcode=E14" for 127.0.0.1 at 2024-03-25 16:01:27 +0530
    Processing by Api::V1::WeatherForecastsController#get_forecast as */*
    Parameters: {"country_code"=>"GB", "zipcode"=>"E14"}
    Pulled weather data from cache    # This line gets logged when data pulled from cache.
    Completed 200 OK in 1ms (Views: 0.3ms | ActiveRecord: 0.0ms)