# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin
User.create(first_name: 'God', last_name: 'Mode', email: 'eftwenty@gmail.com', password: 'pewpew', password_confirmation: 'pewpew', work_variety_list: ['Admin'])