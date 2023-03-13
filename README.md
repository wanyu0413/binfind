# Binfind

BinFind is an innovative app that helps you locate the nearest trash bins in Tokyo. 
With just a few clicks, you can find the nearest bin to dispose of your waste and keep the city clean.


![IMG_6250](https://user-images.githubusercontent.com/51001611/224602108-94979647-0a00-45ac-82b1-272fd3b6729b.jpg)
![IMG_6254](https://user-images.githubusercontent.com/51001611/224602240-dbd01d04-12a0-4178-833a-3ceaf75a403c.jpg)
![IMG_6259](https://user-images.githubusercontent.com/51001611/224602265-0bfb67e5-9dd4-4929-908a-ecd9a21f0bde.jpg)
![IMG_6253](https://user-images.githubusercontent.com/51001611/224602568-d10d0a60-6dd2-4a60-ad9f-7ee25f111a41.jpg)

<br>
App home: https://www.binfind.online/
   

## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```
### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables.
```
MAPBOX_API_KEY=your_own_mapbox_api_key
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
rails bin:attach_photos
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Team Members
- [Julien Afonso](https://www.linkedin.com/in/julien-afonso-59568124b/)
- [Ruka Okuyama](https://www.linkedin.com/in/luka-okuyama-14b87213a/)
- [Wanyu Jiang](https://www.linkedin.com/in/wanyu-jiang-144195248/)
- [Kevin Tsai](https://www.linkedin.com/in/kevin-s-tsai/)
