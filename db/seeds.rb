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

User.destroy_all
Bin.destroy_all
BinCategory.destroy_all
Category.destroy_all

# addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
# serialized_addresses = URI.open(addresses_url).read
# addresses = YAML.load(serialized_addresses)

names = ["Family Mart", "Seven-Eleven", "Lawson", "Maruetsu Supermarket", "Tokyu Supermarket", "Garden Supermarket", "PrecceSupermarket", "Seijo Supermarket", "Basket Supermarket", "Park", "Station", "Impact Hub Parking Lot vending machine", "Building next to Impact Hub vending machine", "Bagel Standard vending machine", "Menchobu Restaurant vending machine", "Apartment vending machine", "Karf vending machine", "Photoshop vending machine", "Meguro Tokyu Store vending machine", "Meguro Station Bus Stop vending machine", "Meguro Station vending machine", "Meguro Gakuen Culture School vending machine", "Across from Meguro Gakuen vending machine", "Across From Family Mart vending machine","Toks vending machine", "Tangle vending machine", "Yamate Buld vending machine", "Sarroq Palace vending machine", "K2 Sagawa vending machine", "Soleil Gotanda vending machine", "Gotanda Station vending machine"]

User.create(email: "kevin@binfind.com", password: "123123")
User.create(email: "wanyu@binfind.com", password: "123123")
User.create(email: "ruka@binfind.com", password: "123123")
User.create(email: "julien@binfind.com", password: "123123")
categories = ["burnable", "can", "pet bottle", "unburnable"]

categories.each do |category|
  Category.create!(name: category)
end
addresses = YAML.load_file("db/data/seven_eleven.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Seven-Eleven",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/7-11.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.all.each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/family_mart.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Family-Mart",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/Family Mart.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.all.each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/lawson.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Lawson",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/lawson.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.all.each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/parks.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Park",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/Park.jpeg")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.where(name: ['burnable']).each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/supermarkets.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Supermarket",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/Preece Meguro.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.all.each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/train_stations.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Train-stations",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/Nakameguro Station.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.all.each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

addresses = YAML.load_file("db/data/vending_machines.yml")
addresses.each do |address|
  bin = Bin.create!(
    address: address,
    name: "Vending-machines",
    # open_time: Tod::TimeOfDay.parse("8am"),
    # end_time: Tod::TimeOfDay.parse("11pm"),
    user: User.all.sample
  )

  file = File.open("app/assets/images/card_photo/Meguro.png")
  bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
  bin.save

  Category.where(name: ['can', 'pet bottle']).each do |category|
    BinCategory.create!(bin: bin, category: category)
  end
end

# Bin.all.each do |bin|
#   BinCategory.create!(bin: bin, category: Category.all.sample)
#   bin.destroy if bin.latitude.nil?
# end
