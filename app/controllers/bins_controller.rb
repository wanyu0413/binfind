require 'exiftool'
require 'open-uri'
class BinsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_bin, only: [:show, :destroy]

  def index
    @bins = policy_scope(Bin)
    if params[:query].present?
      # @bins = Bin.where(category: params[:query])
      @bins = Bin.joins(bin_categories: :category).where(categories: {name: params[:query]})
    end
    @markers = @bins.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude,
        popup_window_html: render_to_string(partial: "popup_window", locals: { bin: bin })
      }
    end
    @categories = Category.all
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
    if @bin.save
      url = @bin.photos.last.url
      location = read_location_from_cloudinary(url)
      @bin.latitude = location[:latitude]
      @bin.longitude = location[:longitude]
      @bin.save
      redirect_to root_path, notice: "Bin was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  #   authorize @bin
  # end

  # def update
  #   authorize @bin
  # end

  def destroy
    authorize @bin
    @bin.destroy
    redirect_to bins_url, notice: "Bin was successfully destroyed."
  end

  private

  def set_bin
    @bin = Bin.find(params[:id])
  end

  def bin_params
    # params.require(:bin).permit(:name, :address, category_ids: [], photos: [])
    params.require(:bin).permit(:name, category_ids: [], photos: [])
  end

  def read_location_from_cloudinary(image_url)
    # Download the image from Google Photos and save it to a local file
    image_data = URI.open(image_url).read
    File.open('image.jpg', 'wb') do |file|
      file.write(image_data)
    end
    # Use Exiftool to read the metadata of the local file
    exiftool = Exiftool.new('image.jpg')

    latitude = exiftool[:gps_latitude]
    longitude = exiftool[:gps_longitude]

    # Print the latitude & longitude
    # puts "Latitude: #{latitude}"
    # puts "Longitude: #{longitude}"

    # Delete the local file
    File.delete('image.jpg')
    {
      latitude: latitude,
      longitude: longitude
    }
  end
end
