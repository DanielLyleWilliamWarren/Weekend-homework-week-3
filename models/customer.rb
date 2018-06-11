require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')

class Customer

attr_accessor(:name, :wallet)
attr_reader(:id)

  def initialize(options)
    @name = options['name']
    @wallet = options['wallet'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO customers
    (name, wallet)
    VALUES
    ($1, $2)
    RETURNING id'
    values = [@name, @wallet]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def update()
    sql = 'UPDATE customers SET (name, wallet) = ($1, $2) WHERE id = $3'
    values = [@name, @wallet, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new( customer ) }
    return result
  end

  def tickets_bought
    sql = "SELECT COUNT(*) FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets[0]['count'].to_i
  end

  def buy_ticket(film_name)
    sql = 'SELECT * FROM films WHERE title = $1'
    values = [film_name]
    film = SqlRunner.run(sql, values)
    # This gets everything from film1(Deadpool), name price etc
    film_hash = film[0]
    @wallet -= film_hash['price'].to_i
    return Ticket.new ({'customer_id' => @id ,'film_id' => film_hash['id'].to_i})
  end

  # or

  # def buy_ticket2(film)
  #   @wallet -= film.price
  #   update()
  #   ticket = Ticket.new ({'customer_id' => @id ,'film_id' => film.id})
  #   ticket.save()
  #   return ticket
  # end

  # def tickets_bought_again
  #   sql = 'SELECT * FROM customers
  #   INNER JOIN tickets
  #   ON tickets.customer_id = customers.id
  #   WHERE customer_id = $1'
  #   values = [@id]
  #   tickets_bought = SqlRunner.run(sql, values)
  #   return  Film.map_items(tickets_bought)
  # end

end
