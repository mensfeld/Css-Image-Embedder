# coding: utf-8

# Converts CSS files - it will embed any img file attached as background
# background: url(...)... --> (base64) -->  url(data:image/png;base64,...)
# By default will embed only images smaller then 32kb

module CssImageEmbedder

  class Converter
    # IE does not accept embed files bigger then 32kb
    DEFAULT_MAX_IMG_SIZE = 32

    attr_reader :result

    def initialize(*sources)
      options = sources.extract_options!.stringify_keys
      source  = options.delete("source")
      @file_path = options.delete("path")
      @root_path = options.delete("root")
      @overwrite = options.delete("overwrite") || false
      @result = nil

      @img_max_size = options.delete("img_max_size") || DEFAULT_MAX_IMG_SIZE

      if @file_path
        raise CssNotFound unless File.exists?(@file_path)
        @source = File.open(@file_path, 'r') { |file| file.read }
      else
        raise CssStringNotProvided unless source
        @source = source
        @overwrite = false
      end

      raise RootPathNotProvided unless @root_path
    end

    # Performe converting
    def convert
      @result = CssImageEmbedder::Engine.new(@root_path, @img_max_size).compress(@source)
    end

    # Saves converted result to file
    def save(filename = nil)
      if @file_path && @overwrite && filename.nil?
        p = @file_path
      else
        p = filename
      end
      f = File.new(p, "w")
      f.write(@result)
      f.close
    end

    # Force overwrite
    def save!(filename = nil)
      @overwrite = true
      save(filename)
    end

    def self.file_to_base64(file)
      CssImageEmbedder::Engine.file_to_base64(file)
    end

  end
end
