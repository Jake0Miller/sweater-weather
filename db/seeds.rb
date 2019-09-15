# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

boulder = Location.create!(name: 'boulder,co', lat: '40', lng: '-120', address: 'Boulder, CO, USA')
Image.create!(location: boulder, raw: 'http', full: 'http', regular: 'http', small: 'http', thumb: 'http')
