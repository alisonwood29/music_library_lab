require('pry-byebug')
require_relative('./models/artists.rb')
require_relative('./models/albums.rb')

Album.delete_all()
Artist.delete_all()

artist_1 = Artist.new({
  'name' => 'Biffy Clyro'
})

artist_2 = Artist.new({
  'name' => 'Beyonce'
})

artist_1.save()
artist_2.save()

album_1 = Album.new({
  'title' => 'The Vertigo of Bliss',
  'genre' => 'Alternative Rock',
  'artist_id' => artist_1.id
  })

album_2 = Album.new({
    'title' => 'Opposites',
    'genre' => 'Alternative Rock',
    'artist_id' => artist_1.id
    })

album_3 = Album.new({
    'title' => 'Lemonade',
    'genre' => 'Pop',
    'artist_id' => artist_2.id
    })

album_1.save()
album_2.save()
album_3.save()

album_1.title = "Only Revolutions"
album_1.update()

artists = Artist.all
albums = Album.all

artists_albums = artist_1.albums()

album_artist = album_1.artist()

binding.pry
nil
