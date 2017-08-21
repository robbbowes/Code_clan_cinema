require_relative( '../models/customer' )
require_relative( '../models/film' )
require_relative( '../models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all
Customer.delete_all
Film.delete_all


customer1 = Customer.new({ 'name' => 'Nicky ', 'funds' => '200' })
customer1.save
customer2 = Customer.new({ 'name' => 'Simon', 'funds' => '300 '})
customer2.save
customer3 = Customer.new({ 'name' => 'Robb', 'funds' => '400' })
customer3.save
customer4 = Customer.new({ 'name' => 'Dan', 'funds' => '500' })
customer4.save

film1 = Film.new({ 'title' => 'El Secreto De Sus Ojos', 'cost' => '50' })
film1.save
film2 = Film.new({ 'title' => 'The Godfather', 'cost' => '60' })
film2.save
film3 = Film.new({ 'title' => 'Before Sunrise', 'cost' => '55' })
film3.save
film4 = Film.new({ 'title' => 'In Bruges', 'cost' => '45' })
film4.save
film5 = Film.new({ 'title' => 'Ghostbusters', 'cost' => '40' })
film5.save


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id })
ticket3.save
ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film4.id })
ticket4.save

Customer.view_all
Film.view_all
Ticket.view_all



pry.binding
nil
