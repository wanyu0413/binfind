# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'yaml'
require 'open-uri'
require 'tod'

puts "Destroy everything..."
User.destroy_all
Bin.destroy_all
BinCategory.destroy_all
Category.destroy_all
puts "done"

# addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
# serialized_addresses = URI.open(addresses_url).read
# addresses = YAML.load(serialized_addresses)

names = ["Family Mart", "Seven-Eleven", "Lawson", "Maruetsu Supermarket", "Tokyu Supermarket", "Garden Supermarket", "PrecceSupermarket", "Seijo Supermarket", "Basket Supermarket", "Park", "Station", "Impact Hub Parking Lot vending machine", "Building next to Impact Hub vending machine", "Bagel Standard vending machine", "Menchobu Restaurant vending machine", "Apartment vending machine", "Karf vending machine", "Photoshop vending machine", "Meguro Tokyu Store vending machine", "Meguro Station Bus Stop vending machine", "Meguro Station vending machine", "Meguro Gakuen Culture School vending machine", "Across from Meguro Gakuen vending machine", "Across From Family Mart vending machine","Toks vending machine", "Tangle vending machine", "Yamate Buld vending machine", "Sarroq Palace vending machine", "K2 Sagawa vending machine", "Soleil Gotanda vending machine", "Gotanda Station vending machine"]

bin_num = (1..7).to_a

puts "Create users..."
User.create(email: "kevin@binfind.com", password: "123123")
User.create(email: "wanyu@binfind.com", password: "123123")
User.create(email: "ruka@binfind.com", password: "123123")
User.create(email: "julien@binfind.com", password: "123123")
categories = ["burnable", "can", "pet bottle", "unburnable"]
puts "done"

categories.each do |category|
  Category.create!(name: category)
end

puts "Create 7eleven bins..."
addresses = YAML.load_file("db/data/seven_eleven.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
    name: "Seven-Eleven",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
   )

    # file = File.open("app/assets/images/card_photo/7-11.png")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

  Category.where(name: ['burnable', 'unburnable', 'pet bottle']).each do |category|
    BinCategory.create!(bin: bin, category: category)
    end
  end
end

puts "Create famima bins..."
addresses = YAML.load_file("db/data/family_mart.yml")
addresses.each do |address|

  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Family-Mart",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )

    # file = File.open("app/assets/images/card_photo/Family Mart.png")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

  Category.where(name: ['burnable', 'unburnable', 'pet bottle']).each do |category|
    BinCategory.create!(bin: bin, category: category)
    end
  end
end

filepath = "db/data/jp_spots.kml"
file = File.open(filepath)
document  = Nokogiri::XML(file)
users = User.all
document.search('Placemark').each_with_index do |coordinates, index|
  next unless index.to_s.include?('12') || index.to_s.include?('13')

  name = coordinates.search('name').text.strip.include?("/") ? coordinates.search('name').text.strip.split("/")[1].strip : coordinates.search('name').text.strip
  p name
  longitude = coordinates.search('coordinates').text.strip.split(",")[0].to_f
  p longitude
  latitude = coordinates.search('coordinates').text.strip.split(",")[1].to_f
  p latitude

  bin = Bin.create(
    name: name,
    latitude: latitude,
    longitude: longitude,
    user: users.sample
  )


  puts "Created #{Bin.count} bins!"
end
puts "Create lawson bins..."
addresses = YAML.load_file("db/data/lawson.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Lawson",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )
  Category.where(name: ['burnable', 'unburnable', 'pet bottle']).each do |category|
    BinCategory.create!(bin: bin, category: category)
   end
  end
end
puts "Create park bins..."
addresses = YAML.load_file("db/data/parks.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Park",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )

    # file = File.open("app/assets/images/card_photo/Park.jpeg")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

    Category.where(name: ['burnable']).each do |category|
      BinCategory.create!(bin: bin, category: category)
    end
  end
end

puts "Create supa bins..."
addresses = YAML.load_file("db/data/supermarkets.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Supermarket",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )

    # file = File.open("app/assets/images/card_photo/Preece Meguro.png")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

    Category.all.each do |category|
      BinCategory.create!(bin: bin, category: category)
    end
  end
end

puts "Create train bins..."
addresses = YAML.load_file("db/data/train_stations.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Train-stations",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )

    # file = File.open("app/assets/images/card_photo/Nakameguro Station.png")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

    Category.all.each do |category|
      BinCategory.create!(bin: bin, category: category)
    end
  end
end
puts "Create jidohanbaiki bins..."
addresses = YAML.load_file("db/data/vending_machines.yml")
addresses.each do |address|
  bin_num.each do |num|
    bin = Bin.create!(
      address: num.to_s + address[1..-1],
      name: "Vending-machines",
      # open_time: Tod::TimeOfDay.parse("8am"),
      # end_time: Tod::TimeOfDay.parse("11pm"),
      user: User.all.sample
    )

    # file = File.open("app/assets/images/card_photo/Meguro.png")
    # bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    # bin.save

    Category.where(name: ['can', 'pet bottle']).each do |category|
      BinCategory.create!(bin: bin, category: category)
    end
  end
end

# Bin.all.each do |bin|
#   BinCategory.create!(bin: bin, category: Category.all.sample)
#   bin.destroy if bin.latitude.nil?
# end
