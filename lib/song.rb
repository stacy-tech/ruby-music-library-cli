
 require 'pry'
# require_relative "../config/environment.rb"

class Song 

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        # self.artist = artist
        self. artist=artist if artist
        # self.genre = genre 
        self.genre=genre if genre
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
        # song = Song.new(name)
       song = self.new(name)
       song.save
       song 
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
        # if artist = nil && artist.songs.include?(self)
        #     artist.add_song(self)
        # end
        # @artist = artist
    end 

    def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
            genre.songs << self
        end
    end

    def self.find_by_name(name)
        @@all.select{|song| song.name ==  name}[0]
    end 

    def self.find_or_create_by_name(title)
        song = self.find_by_name(title)
        if song == nil
            self.create(title)
        else
            song
        end
        # if self.find_by_name(name)
        #     return self.find_by_name(name)
        # else
        #     self.create(name)
        # end
        
    end

    def self.new_from_filename(file_name)
        array = file_name.split(" - ")

        song_name = array[1]
        artist_name = array[0]
        genre_name = array[2].split(".mp3").join

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
    end 

    def self.create_from_filename(file_name)
        song = Song.new_from_filename(file_name)
        song.save
    end 

end 