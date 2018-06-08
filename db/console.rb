require('pry')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name' => 'Dan',
  'wallet' => 1000
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Dave',
  'wallet' => 1500
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'Gabby',
  'wallet' => 750
  })
customer3.save()

film1 = Film.new({
 'title' => 'Deadpool',
 'price' => 100
  })
film1.save()

film2 = Film.new({
  'title' => 'Solo',
  'price' => 50
  })
film2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
  ticket1.save()

ticket2 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket2.save()

ticket3 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
  ticket3.save()

ticket4 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film2.id
  })
  ticket4.save()

  binding.pry
  nil
