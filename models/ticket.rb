require_relative('../db/sql_runner')

class Ticket

  attr_reader(:id, :customer_id, :film_id)

  def initialize(details)
    @id = details['id'].to_i()
    @customer_id = details['customer_id'].to_i()
    @film_id = details['film_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets
      (customer_id, film_id)
      VALUES ($1, $2)
      RETURNING id;'
    values = [@customer_id, @film_id]
    save_ticket = SqlRunner.run(sql, values)
    result = save_ticket.map { |ticket| Ticket.new(ticket) }
  end

  def self.view_all
    sql = 'SELECT * FROM tickets;'
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return tickets
  end

  def self.delete_all
    sql = 'DELETE FROM tickets;'
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM tickets WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = 'UPDATE tickets SET (customer_name, film_id) = ($1, $2) WHERE id = $3;'
    values = [@customer_name, @film_id, @id]
    SqlRunner.run(sql, values)
  end

end
