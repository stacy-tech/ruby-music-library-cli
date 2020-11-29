class MusicImporter

    attr_accessor :path

    def initialize(filepath)
        @path = filepath
    end 

    def files
        path = @path+"/*.mp3"
        @files = Dir[path]
        @files.collect do |file|
            file.split(/\/.+\//)[1]
        end 
    end 

    def import 
        path = @path+"/*.mp3"
        @files = Dir[path]
        @files.each do |file|
            song_name = file.split(/\/.+\//)[1]
            Song.create_from_filename(song_name)
        end
    end
end 