require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name)
    VALUES ($1)
    RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map {|artist| Artist.new(artist)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    albums_by_artist = SqlRunner.run(sql, values)
    return albums_by_artist.map {|album| Album.new(album)}
  end

  def Artist.delete_all()
    SqlRunner.run("DELETE FROM artists;")
  end

  def update()
    sql = "UPDATE artists
          SET name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

end
