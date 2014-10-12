module Mapgruff
  class TableGenerator
    attr_reader :column_sizes

    HEADERS = ["city", "category", "primary_type", "description", "date", "block"]

    def initialize(incidents)
      @incidents = incidents
      @column_sizes = hash_with_header_keys
      calculate_column_lengths
    end

    def create_table
      table = ""
      table += create_top_box_row
      table += create_header_row
      table += create_separator_row
      @incidents.each do |incident|
        table += create_data_row(incident)
      end
      table += create_bottom_row
    end

    def calculate_column_lengths
      headers_and_entries = generate_headers_and_entries
      headers_and_entries.each { |k, v| @column_sizes[k] = calculate_header_size(k, v)}
    end

    def generate_headers_and_entries
      headers_and_entries = hash_with_header_keys
      assign_entries_to_headers(headers_and_entries)
    end

    def assign_entries_to_headers(headers_and_entries)
      @incidents.each { |incident| incident.each { |k, v| headers_and_entries[k] << v } }
      headers_and_entries
    end

    def calculate_header_size(header, entries)
      padding = 2
      largest_entry_length = entries.map(&:length).max
      header_length = header.length
      if largest_entry_length > header_length
        padding += largest_entry_length
      else
        padding += header_length
      end
    end

    def sum_of_columns
      num = 0
      @column_sizes.each { |k, v| num += v}
      num
    end

    def create_top_box_row
      top_box = " "
      top_box += ("_" * (sum_of_columns + 5))
      top_box += "\r\n"
    end

    def create_header_row
      header_row = "| "
      @column_sizes.each do |k, v|
        difference = v - k.length
        header_row += k.upcase
        header_row += (" " * (difference - 1))
        header_row += "| "
      end
      header_row.chop!
      header_row += "\r\n"
    end

    def create_separator_row
      separator_row = "|"
      @column_sizes.each do |k, v|
        separator_row += ("-" * v)
        separator_row += "|"
      end
      separator_row += "\r\n"
    end

    def create_data_row(incident)
      data_row = "| "
      incident.each do |k, v|
        header_size = @column_sizes[k]
        difference = 0
        if header_size > v.length
          difference = header_size - v.length
        end
        data_row += v.upcase
        data_row += (" " * (difference - 1))
        data_row += "| "
      end
      data_row.chop!
      data_row += "\r\n"
    end

    def create_bottom_row
      bottom_row = "|"
      bottom_row += ("_" * (sum_of_columns + 5))
      bottom_row += "|"
      bottom_row += "\r\n"
    end

    private

    def hash_with_header_keys
      Hash[HEADERS.collect { |v| [v, []] }]
    end

  end
end
