module Mapgruff
  class Presenter
    def initialize(output, table_generator)
      @output = output
      @table_generator = table_generator
    end

    def present_table
      @output.puts(@table_generator.create_table)
    end
  end
end
