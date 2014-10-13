require 'httparty'

module Mapgruff
  class IncidentFetcher

    BASE_URL = "http://198.58.110.111"

    CITY_URLS = { :chicago => "#{BASE_URL}/all_chicago",
                  :seattle => "#{BASE_URL}/all_seattle" }

    def self.fetch_for_city(city)
      city_url = get_city_url(city)
      JSON.parse(HTTParty.get(city_url))
    end

    def self.get_city_url(city)
      CITY_URLS[city.downcase.to_sym]
    end
  end
end
