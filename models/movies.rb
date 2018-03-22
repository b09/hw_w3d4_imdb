require_relative('../db/sql_runner')


class Movie

  attr_reader :id
  attr_accessor :title, :genre, :rating

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_i
  end

  def save
    # the output of sqlrunner comes from the pg gem which always returns an array of hashes [{...}] so if a response is requested from the
    # database, in the case below 'RETURN id', the output will go through pg and will therefore be an array of hashes

    sql = "
    INSERT INTO movies (title, genre, rating) VALUES ($1,$2,$3) RETURNING id
    "
    values = [@title, @genre, @rating]
    movie_hash = SqlRunner.run(sql, values).first
    @id = movie_hash['id'].to_i
  end

  def self.view_all
    sql = "
    SELECT * FROM movies
    "
    values = []
    array_hashes = SqlRunner.run(sql, values)
    each_movie = array_hashes.map { |movie| Movie.new(movie) }
    return each_movie
  end

  def update
    sql = "
    UPDATE movies SET (title, genre, rating) = ($1, $2, $3) WHERE id = $4
    "
    values = [@title, @genre, @rating, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "
    DELETE FROM movies WHERE id = $1
    "
    value = [@id]
    SqlRunner.run(sql, value)
  end

end
