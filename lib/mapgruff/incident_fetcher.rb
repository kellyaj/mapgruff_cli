require 'httparty'

module Mapgruff
  class IncidentFetcher

    CITY_URLS = {
                  :chicago => "http://198.58.110.111/all_chicago",
                  :seattle => "http://198.58.110.111/all_seattle"
                }

    def self.fetch_for_city(city)
      JSON.parse(HTTParty.get(get_city_url(city)))
    end

    def self.get_city_url(city)
      CITY_URLS[city.downcase.to_sym]
    end
  end
end
