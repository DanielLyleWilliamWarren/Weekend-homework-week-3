require('pg')
require_relative('../db/sql_runner.rb')

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

end
