class BinsController < ApplicationController

  def index
    @bins = policy_scope(Bin)
    @markers = @bins.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude,
        popup_window_html: render_to_string(partial: "popup_window", locals: {bin: bin})
      }
    end
  end

  def show
    authorize @bin
  end

  def new
    @bin = Bin.new
    authorize @bin
  end

  def create
    @bin = Bin.new(bin_params)
    @bin.user = current_user
    authorize @bin
  end

  def edit
    authorize @bin
  end

  def update
    authorize @bin
  end

  def destroy
    authorize @bin
  end
end
