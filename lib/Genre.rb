
require 'pry'
class Genre

    extend Concerns::Findable

    attr_accessor :name
    attr_reader :songs

    @@all = []
    
    def initialize(name)
        @songs = []
        @name = name
        @@all << self
    end 

    def self.all
        @@all
    end

    def save 
        @@all << self
    end 

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        genre = self.new(name)
        genre.save
        genre
    end 

    def artists
       self.songs.collect{|s| s.artist}.uniq
    end 

    def songs
        @songs
    end
end 