require 'spec_helper'
require 'stringio'

describe Mapgruff::Presenter do
  it "displays the table" do
    output = StringIO.new
    mock_generator = double("TableGenerator")
    presenter = Mapgruff::Presenter.new(output, mock_generator)
    table = "some cool formatted table"
    allow(mock_generator).to receive(:create_table) { table }

    expect(output).to receive(:puts).with(table)

    presenter.present_table
  end
end
