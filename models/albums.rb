require_relative("../db/sql_runner.rb")

class Album

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Album.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map {|album| Album.new(album)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values)
    artist_object = artist_hash[0]
    return artist_object
  end

  def Album.delete_all
    SqlRunner.run("DELETE FROM albums;")
  end

  def update()
    sql = "UPDATE albums
        SET (title, genre, artist_id)
        = ($1, $2, $3)
        WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def Album.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album_hash = SqlRunner.run(sql, values)
    album_object = album_hash[0]
    return album_object
    # return album_hash.map {|album| Album.new(album)}
  end

end
