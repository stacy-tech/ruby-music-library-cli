
require 'pry'
class MusicLibraryController

    attr_accessor :path

    def initialize(path = "./db/mp3s")
        @path = path
        @music_importer = MusicImporter.new(path)
        @music_importer.import
    end 

    def call
        input = nil

        puts "Welcome to your music library!"
        # puts "what would you like to do?"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        until input == "exit"
            input = gets.strip
            if input == "list songs"
                list_songs
            elsif input == 'list artists'
                list_artists
            elsif input == 'list genres'
                list_genres
            elsif input == 'play song'
                play_song
            end
        end
    end

    def list_songs
        all_songs = Song.all
        all_songs.sort! {|song_1, song_2| song_1.name <=> song_2.name}
        all_songs.collect! {|song| "#{song.artist.name} - #{song.name} -" + song.genre.name}
        all_songs.each_with_index {|song, index| puts "#{index + 1}." + song }
    end

    def list_artists
        all_artists = Artist.all
        all_artists.collect! {|artist| artist.name}.sort!
        all_artists.each_with_index {|artist, index| puts "#{index + 1}." + artist }
    end

    def list_genres 
        genres = Genre.all.sort {|a,b| a.name <=> b.name} 
        genres.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}" 
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort { |a,b| a.name <=> b.name }.each.with-index(1) do |song, i|
                puts "#{i}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        end
    end 

    def play_song
        puts "Which song number would you like to play?"
        number_chosen = gets.strip.to_i
        real_index = number_chosen-1
        if (1..Song.all.length-1).include? real_index
            sorted_songs = Song.all.sort{|prev_song,next_song| prev_song.name <=> next_song.name}
            song_chosen = sorted_songs[number_chosen-1]
            puts "Playing #{song_chosen.name} by #{song_chosen.artist.name}"
        end
    end


end 