require 'spec_helper'
require 'webmock/rspec'

describe Mapgruff::IncidentFetcher do

  def stub_request_for(city)
    mocked_response = [
      {"some" => "data"},
      {"other" => "data"}
    ].to_json
    stub_request(:get, "http://198.58.110.111/all_#{city}").to_return(:status => 200, :body => mocked_response)
  end

  context "fetching incidents" do

    it "fetches Seattle incidents" do
      stub_request_for("seattle")
      incidents = Mapgruff::IncidentFetcher.fetch_for_city("Seattle")

      expect(incidents.length).to eq(2)
    end

    it "fetches Chicago incidents" do
      stub_request_for("chicago")
      incidents = Mapgruff::IncidentFetcher.fetch_for_city("Chicago")

      expect(incidents.length).to eq(2)
    end
  end
end
