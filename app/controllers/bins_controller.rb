class BinsController < ApplicationController
  def index
    @bins = Bin.all
    @markers = @bins.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude
      }
    end
  end
end
