class CsvController < ApplicationController
  require 'csv'

  def new
  end

  def create

    csv_text = params[:csv_file].read

    CSV.parse(csv_text, :headers => true) do |row|
      # I hate this part, just didn't yet think about how to make it less ugly.
      # (Maybe something like csv_header -> Model.field correspondence
      #  in app config file, and then traversing each header in a row)

      logger.info row.inspect
    end

  end
end
