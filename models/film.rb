require('pg')
require_relative('../db/sql_runner.rb')

class Film

attr_reader(:id)
attr_accessor(:title, :price)

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id'
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3'
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

end
