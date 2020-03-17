class Song
  
  attr_accessor :name, :artist, :genre
  
  @@all = [ ]
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save 
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
    @@all.find{ |song| song.name == name }
  end
  
  def self.find_or_create_by_name(name) 
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(file_name)
    song_name = file_name.split(" - ")[1]
    artist_name = file_name.split(" - ")[0]
    genre_name = file_name.split(" - ")[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new_song = self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).tap{ |x| x.save }
  end
  
end