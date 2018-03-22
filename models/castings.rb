require_relative('../db/sql_runner')

class Casting

  attr_reader :id, :movie_id, :star_id
  attr_accessor :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @fee = options['fee']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
  end

  def save
    # the output of sqlrunner comes from the pg gem which always returns an array of hashes [{...}] so if a response is requested from the
    # database, such as in the case below with 'RETURN id', the output will go through pg and will therefore be an array of hashes

    sql = "
    INSERT INTO castings (fee, movie_id, star_id) VALUES ($1,$2,$3) RETURNING id
    "
    values = [@fee, @movie_id, @star_id]
    casting_hash = SqlRunner.run(sql, values).first
    @id = casting_hash['id'].to_i
  end

  def self.view_all
    sql = "
    SELECT * FROM castings
    "
    values = []
    array_hashes = SqlRunner.run(sql, values)
    each_casting = array_hashes.map { |casting| Casting.new(casting) }
    return each_casting
  end

  def update
    sql = "
    UPDATE castings SET (fee, movie_id, star_id) = ($1, $2, $3) WHERE id = $4
    "
    values = [@fee, @movie_id, @star_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "
    DELETE FROM castings WHERE id = $1
    "
    value = [@id]
    SqlRunner.run(sql, value)
  end

  def find_by_stars_id()
    sql = "
    SELECT * FROM castings
    "
  end

end
