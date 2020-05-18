require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


PIZZA_MENU = Rails.root.join('db', 'pizzas-seeds.csv')

pizza_fails = []
CSV.foreach(PIZZA_MENU, :headers => true) do |row|
  pizza = Pizza.new
  pizza.crust = row['crust']
  pizza.name = row['name']
  pizza.sauce = row['sauce']
  pizza.cheese = row['cheese']
  pizza.toppings = row['toppings']
  successful = pizza.save
  if !successful
    pizza_fails << pizza
    puts "Failed to save pizza: #{pizza.inspect}"
  else
    puts "Created pizza: #{pizza.inspect}"
  end
end

puts "Added #{Pizza.count} pizza records."
puts "#{pizza_fails.length} pizzas failed to save."
