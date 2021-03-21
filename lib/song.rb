require 'pry'

class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist != nil 
        self.genre=(genre) if genre != nil 
    end 

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
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

    def artist
        @artist
    end 

    def genre=(genre)
        @genre = genre
    end 

    def genre
        @genre
    end 

    def self.find_by_name(name)
        self.all.find { | song | song.name == name }
    end 

    def self.find_or_create_by_name(name)
        if self.find_by_name(name)
            self.find_by_name(name)
        else 
            self.create(name)
        end
    end

    def self.new_from_filename(filename)
        song_info = filename.split(" - ")
        
        song_name = song_info[1]
        song_artist = song_info[0]
        song_genre = song_info[2].gsub(".mp3", "")
        
        artist = Artist.find_or_create_by_name(song_artist)
        genre = Genre.find_or_create_by_name(song_genre)
        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

end 