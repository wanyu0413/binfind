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

addresses_url = 'https://gist.githubusercontent.com/trouni/599e03440e2552e803c54c62916f874c/raw/cc7aff8deeb27c3f22ee501b6723766a8cb68f2b/addresses.yml'
serialized_addresses = URI.open(addresses_url).read
addresses = YAML.load(serialized_addresses)

names = ["Family Mart","Seven-Eleven", "Lawson", "Maruetsu", "Tokyu", "Garden", "Precce", "Seijo", "Basket", "Park", "Station", "Impact Hub Parking Lot vending machine", "Building next to Impact Hub vending machine", "Bagel Standard vending machine", "Menchobu Restaurant vending machine", "Apartment vending machine", "Karf vending machine", "Photoshop vending machine", "Meguro Tokyu Store vending machine", "Meguro Station Bus Stop vending machine", "Meguro Station vending machine", "Meguro Gakuen Culture School vending machine", "Across from Meguro Gakuen vending machine", "Across From Family Mart vending machine","Toks vending machine", "Tangle vending machine", "Yamate Buld vending machine", "Sarroq Palace vending machine", "K2 Sagawa vending machine", "Soleil Gotanda vending machine", "Gotanda Station vending machine"]

categories = ["burnable", "can", "pet bottle", "unburnable"]


user = User.create!(email: 'binfind@email.com', password: '123123')
addresses.each do |address|
  capacity = [true, false].sample
  Bin.create!(
    address:address,
    name:names.sample,
    open_time: Tod::TimeOfDay.parse("8am"),
    end_time:Tod::TimeOfDay.parse("11pm"),
    category:categories.sample,
    capacity: capacity,
    user: user
  )
end
