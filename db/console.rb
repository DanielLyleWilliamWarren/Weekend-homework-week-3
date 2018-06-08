require('pry')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

customer1 = Customer.new({
  'name' => 'Dan',
  'wallet' => 1000
  })

customer2 = Customer.new({
  'name' => 'Dave',
  'wallet' => 1500
  })

customer3 = Customer.new({
  'name' => 'Gabby',
  'wallet' => 750
  })

film1 = Film.new({
 'title' => 'Deadpool',
 'price' => 100
  })

film2 = Film.new({
  'title' => 'Solo',
  'price' => 50
  })

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket2 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket3 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
ticket4 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film2.id
  })
  binding.pry
  nil
