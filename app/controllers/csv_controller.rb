class CsvController < ApplicationController
  require 'csv'

  def new
  end

  def create
    csv_text = params[:csv_file].read
    CSV.parse(csv_text, :headers => true) { |row| Transaction.import_row row }
  end
end
