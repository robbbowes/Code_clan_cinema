require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize( details )
    @id = details['id'].to_i
    @name = details['name']
    @funds = details['funds']
  end

  def save
    sql = 'INSERT INTO customers (name, funds)
    VALUES ($1, $2) RETURNING id;'
    values = [@name, @funds]
    user = SqlRunner.run(sql, values).first
    @id = user['id'].to_i
  end

  def self.view_all()
    sql = 'SELECT * FROM customers;'
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM customers;'
    values = []
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE customers SET (
      name, funds
      ) = (
      $1, $2
      )
      WHERE id = $3;'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM customers WHERE
      id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def which_films
    sql = 'SELECT * FROM films
      INNER JOIN tickets ON films.id = tickets.film_id
      WHERE customer_id = $1;'
    values = [@id]
    results = SqlRunner.run(sql, values)
    which_films = results.map { |film| Film.new(film) }
    return which_films
  end



  def






  # def buy_ticket
  #   sql = 'UPDATE customers SET
  #    ( funds )
  #       =
  #    ( $1 )
  #     INNER JOIN tickets on films.id = tickets.film_id
  #     WHERE customer_id = $2;'
  #     new_funds = @funds.to_i - @cost.to_i
  #     values = [new_funds, @id]
  #     results = SqlRunner.run(sql, values)
  # end


end
