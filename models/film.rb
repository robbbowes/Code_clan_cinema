require_relative('../db/sql_runner')

class Film

  attr_reader(:id)
  attr_accessor(:name)

  def initialize(details)
    @id = details['id'].to_i
    @name = details['title']
    @cost = details['cost'].to_i
  end

  def save
    sql = 'INSERT INTO films (title, cost)
      VALUES ($1, $2) RETURNING id;'
      values = [@name, @cost]
      film = SqlRunner.run(sql, values).first
      @id = film['id'].to_i
  end

  def Film.view_all
    sql = 'SELECT * FROM films;'
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.delete_all
    sql = 'DELETE FROM films;'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM films WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE films SET (name, cost) = ($1, $2) WHERE id = $3;'
    values = [@name, @cost, @id]
    SqlRunner.run(sql, values)
  end

  def which_customers
    sql = 'SELECT * FROM customers
      INNER JOIN tickets ON customers.id = tickets.customer_id
      WHERE film_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    which_customers = results.map {|customer| Customer.new(customer)}
    return which_customers
  end



end
