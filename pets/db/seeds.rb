# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Pet.delete_all
Pet.create(:name => 'Abe',
  :breed => 'Domestic Shorthair',
  :image_url => 'abe.jpg',
  :age => 1,
  :shots => true,
  :status => "Available",
  :notes => "None")

Pet.create(:name => 'Ben',
  :breed => 'Domestic Shorthair',
  :image_url => 'ben.jpg',
  :age => 4,
  :shots => true,
  :status => "Available",
  :notes => "Has hair.")

Pet.create(:name => 'Ena',
  :breed => 'Llama',
  :image_url => 'ena.jpg',
  :age => 3,
  :shots => true,
  :status => "Available",
  :notes => "Notes.")

Pet.create(:name => 'Nat',
  :breed => 'Pig',
  :image_url => 'nat.jpg',
  :age => 9,
  :shots => false,
  :status => "Available",
  :notes => "A pig.")
