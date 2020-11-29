
require 'pry'
# require_relative "../config/environment.rb"

class Artist

    extend Concerns::Findable

    attr_accessor :name, :genres, :artist
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
        @songs = []
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
        artist = Artist.new(name)
        artist.save
        artist
    end 

    def add_song(song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end 

    def songs
        @songs
    end

    def genres
        songs.collect { |song| song.genre}.uniq
    end 
        

end 