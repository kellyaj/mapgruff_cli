require 'spec_helper'
require 'stringio'

describe Mapgruff::Presenter do

  before(:each) do
    @incidents = [
      {
        "city"         => "Seattle",
        "category"     => "PROPERTY",
        "primary_type" => "car prowl",
        "description"  => "something",
        "date"         => "8/9/2014 09:28",
        "block"        => "19XX 4th Ave"
      },
      {
        "city"         => "Seattle",
        "category"     => "VIOLENT",
        "primary_type" => "assault",
        "description"  => "something else",
        "date"         => "11/19/2014 19:28",
        "block"        => "15XX Eastlake"
      }
    ]
    @output = StringIO.new
    @presenter = Mapgruff::Presenter.new(@output, @incidents)
  end

  context "calculating column lengths" do
    it "adjusts a header size based on the largest entry for that header" do
      header = "PRIMARY TYPE"
      entries = ["CAR PROWL", "PUBLIC INTOXICATION"]
      calculated_length = @presenter.calculate_header_size(header, entries)

      expect(calculated_length).to eq(21)
    end

    it "uses the header length if entries are smaller than header length" do
      header = "DESCRIPTION"
      entries = ["small", "micro"]

      calculated_length = @presenter.calculate_header_size(header, entries)

      expect(calculated_length).to eq(13)
    end

    it "creates a key-value pairing of headers-entries" do
      headers_and_entries = {
        "city"         => [@incidents[0]["city"], @incidents[1]["city"]],
        "category"     => [@incidents[0]["category"], @incidents[1]["category"]],
        "primary_type" => [@incidents[0]["primary_type"], @incidents[1]["primary_type"]],
        "description"  => [@incidents[0]["description"], @incidents[1]["description"]],
        "date"         => [@incidents[0]["date"], @incidents[1]["date"]],
        "block"        => [@incidents[0]["block"], @incidents[1]["block"]]
      }

      expect(@presenter.generate_headers_and_entries).to eq(headers_and_entries)
    end

    it "creates an hash of column sizes" do
      expected_column_sizes = {
        "city"         => 9,
        "category"     => 10,
        "primary_type" => 14,
        "description"  => 16,
        "date"         => 18,
        "block"        => 15
      }
      expect(@presenter.column_sizes).to eq(expected_column_sizes)
    end

    it "sums the value of all column sizes" do
      expect(@presenter.sum_of_columns).to eq(82)
    end
  end

  context "displaying the header" do
    it "creates the top box row" do
      top_box_row = " _______________________________________________________________________________________"
      expect(@presenter.create_top_box_row).to eq(top_box_row)
    end

    it "creates the header row" do
      header_row = "| CITY    | CATEGORY | PRIMARY_TYPE | DESCRIPTION    | DATE             | BLOCK         |"

      expect(@presenter.create_header_row).to eq(header_row)
    end

    it "creates the separator row" do
      separator_row = "|---------|----------|--------------|----------------|------------------|---------------|"

      expect(@presenter.create_separator_row).to eq(separator_row)
    end

    it "creates a data representation row" do
      data_row = "| SEATTLE | PROPERTY | CAR PROWL    | SOMETHING      | 8/9/2014 09:28   | 19XX 4TH AVE  |"

      expect(@presenter.create_data_row(@incidents[0])).to eq(data_row)
    end

    it "creates the bottom row" do
      bottom_row = "|_______________________________________________________________________________________|"

      expect(@presenter.create_bottom_row).to eq(bottom_row)
    end

    it "displays the table" do
      top_box_row = " _______________________________________________________________________________________"
      header_row = "| CITY    | CATEGORY | PRIMARY_TYPE | DESCRIPTION    | DATE             | BLOCK         |"
      separator_row = "|---------|----------|--------------|----------------|------------------|---------------|"
      first_data_row = "| SEATTLE | PROPERTY | CAR PROWL    | SOMETHING      | 8/9/2014 09:28   | 19XX 4TH AVE  |"
      second_data_row = "| SEATTLE | VIOLENT  | ASSAULT      | SOMETHING ELSE | 11/19/2014 19:28 | 15XX EASTLAKE |"
      bottom_row = "|_______________________________________________________________________________________|"

      allow(@output).to receive(:puts)
      expect(@output).to receive(:puts).with(top_box_row)
      expect(@output).to receive(:puts).with(header_row)
      expect(@output).to receive(:puts).with(separator_row)
      expect(@output).to receive(:puts).with(first_data_row)
      expect(@output).to receive(:puts).with(second_data_row)
      expect(@output).to receive(:puts).with(bottom_row)

      @presenter.present
    end
  end
end
