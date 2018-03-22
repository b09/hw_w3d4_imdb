require_relative('../db/sql_runner')


class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save
    # the output of sqlrunner comes from the pg gem which always returns an array of hashes [{...}] so if a response is requested from the
    # database, in the case below 'RETURN id', the output will go through pg and will therefore be an array of hashes

    sql = "
    INSERT INTO stars (first_name, last_name) VALUES ($1,$2) RETURNING id
    "
    values = [@first_name, @last_name]
    star_hash = SqlRunner.run(sql, values).first
    @id = star_hash['id'].to_i
  end

  def self.view_all
    sql = "
    SELECT * FROM stars
    "
    values = []
    array_hashes = SqlRunner.run(sql, values)
    each_star = array_hashes.map { |star| Star.new(star) }
    return each_star
  end

  def update
    sql = "
    UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3
    "
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "
    DELETE FROM stars WHERE id = $1
    "
    value = [@id]
    SqlRunner.run(sql, value)
  end

end
