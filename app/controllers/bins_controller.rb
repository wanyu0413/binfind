require 'exiftool'
require 'open-uri'
class BinsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_bin, only: [:show, :destroy]

  def index
    @bins = policy_scope(Bin)

    @bin = Bin.new
    if params[:query].present?
      # @bins = Bin.where(category: params[:query])
      @bins = Bin.joins(bin_categories: :category).where(categories: {name: params[:query]})
    end
    if params[:lat].present?
      @bins = @bins.geocoded.near([params[:lat], params[:lng]], 1)
    end
    @markers = @bins.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude,
        popup_window_html: render_to_string(partial: "popup_window", locals: { bin: bin }),
        marker_html: render_to_string(partial: "marker")
      }
    end
    @categories = Category.all
  end

  def show
    authorize @bin
  end

  def create
    @bin = Bin.new(bin_params)
    @bin.user = current_user
    location = read_coordinates(bin_params[:photos].last.tempfile.path)
    puts "=" * 50
    p @bin.latitude = location[:latitude]
    p @bin.longitude = location[:longitude]
    puts "=" * 50

    authorize @bin
    if @bin.save
      redirect_to bins_url(lat: @bin.latitude, lng: @bin.longitude), notice: "Bin was successfully created."
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

  def read_coordinates(image_path)

    # Use Exiftool to read the metadata of the local file
    pp exiftool = Exiftool.new(image_path)

    latitude = exiftool[:gps_latitude]
    longitude = exiftool[:gps_longitude]

    # Print the latitude & longitude
    # puts "Latitude: #{latitude}"
    # puts "Longitude: #{longitude}"

    {
      latitude: latitude,
      longitude: longitude
    }
  end
end
