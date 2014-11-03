require 'open-uri'
require 'json'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class ForecastsController < ApplicationController
  def weatheroutput
    @the_address = params["address"]
    url_safe_address = URI.encode(@the_address)

    url_of_data_we_want ="http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_address.to_s + "&sensor=false"
    raw_data = open(url_of_data_we_want).read
    parsed_data = JSON.parse(raw_data)
    the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/23f3953b05f926b4064525e3392e120f/" + the_latitude.to_s + "," + the_longitude.to_s
    currentforecast_raw = open(weather_url).read
    parsed_weatherdata = JSON.parse(currentforecast_raw)

    @the_temperature = parsed_weatherdata["currently"]["temperature"]
    @the_hour_outlook = parsed_weatherdata["hourly"]["data"][1]["summary"]
    @the_day_outlook = parsed_weatherdata["daily"]["data"][1]["summary"]

    render 'weatheroutput'

  end

end
