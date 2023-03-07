require 'exiftool'
require 'open-uri'

# Download the image from Google Photos and save it to a local file
image_url = 'https://res.cloudinary.com/danormjlb/image/upload/v1678093402/IMG_0807_oskqpr.heic'
image_data = URI.open(image_url).read
File.open('image.jpg', 'wb') do |file|
  file.write(image_data)
end
# Open the file again and read its contents
# file_contents = File.read('image.jpg')

# Print the file contents
# File.write("output.txt", file_contents)
# Use Exiftool to read the metadata of the local file
exiftool = Exiftool.new('image.jpg')

latitude = exiftool[:gps_latitude]
longitude = exiftool[:gps_longitude]

# Print the latitude & longitude
puts "Latitude: #{latitude}"
puts "Longitude: #{longitude}"

# Delete the local file
File.delete('image.jpg')
