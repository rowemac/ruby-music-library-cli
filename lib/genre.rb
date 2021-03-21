require 'pry'

class Genre
    extend Concerns::Findable
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        save
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

    def self.create(genre)
        genre = self.new(genre)
        genre
    end

    def songs
        Song.all.select { | song | song.genre == self }
    end

    def artists
        unique_artists = []
        Song.all.select do | song | 
            if song.genre == self
                unique_artists << song.artist
            end
        end
        unique_artists.uniq
    end





end 