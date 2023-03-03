namespace :bin do
  desc "Attaches photos to our bins"
  task attach_photos: :environment do
    puts "7-11"
    bins = Bin.where(name: "Seven-Eleven")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/7-11.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "famima"
    bins = Bin.where(name: "Family-Mart")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/Family Mart.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "lawson"
    bins = Bin.where(name: "Lawson")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/lawson.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "park"
    bins = Bin.where(name: "Park")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/Park.jpeg")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "supermarket"
    bins = Bin.where(name: "Supermarket")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/Preece Meguro.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "train station"
    bins = Bin.where(name: "Train-stations")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/Nakameguro Station.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
    puts "vending machines"
    bins = Bin.where(name: "Vending-machines")
    bins.each do |bin|
      file = File.open("app/assets/images/card_photo/Meguro.png")
      bin.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
      bin.save
    end
  end
end
#rails bin:attach_photos
