require 'spec_helper'
require 'webmock/rspec'

describe Mapgruff::IncidentFetcher do
  context "fetching incidents" do
    it "fetches Seattle incidents" do
      mocked_response = [
        {"some" => "data"},
        {"other" => "data"}
      ].to_json
      stub_request(:get, "http://198.58.110.111/all_seattle").to_return(:status => 200, :body => mocked_response)
      incidents = Mapgruff::IncidentFetcher.fetch_for_city(:seattle)

      expect(incidents.length).to eq(2)
    end

    it "fetches Chicago incidents" do
      mocked_response = [
        {"some" => "data"},
        {"other" => "data"}
      ].to_json
      stub_request(:get, "http://198.58.110.111/all_chicago").to_return(:status => 200, :body => mocked_response)
      incidents = Mapgruff::IncidentFetcher.fetch_for_city(:chicago)

      expect(incidents.length).to eq(2)
    end
  end
end
