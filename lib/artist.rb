require 'pry'

class Artist
    extend Concerns::Findable
    attr_accessor :name

    @@all = []
    
    def initialize(name)
        @name = name
        self.save
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
       self.new(name)
    end 

    def songs 
        Song.all.select {| song | song.artist == self }
    end

    def add_song(song)
        if song.artist == nil 
            song.artist = self
        end
    end

    def genres
        unique_genres = []
        Song.all.select do | song | 
            if song.artist == self
                unique_genres << song.genre
            end
        end
        unique_genres.uniq
    end





end 