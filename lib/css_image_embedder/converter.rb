# coding: utf-8

# Converts CSS files - it will embed any img file attached as background
# background: url(...)... --> (base64) -->  url(data:image/png;base64,...)
# Domyślnie osadza w CSSie tylko pliki mniejsze niz 32kb

require 'base64'
module CssImageEmbedder
  class Converter
    # IE does not accept embed files bigger then 32kb
    DEFAULT_MAX_IMG_SIZE = 32*1024

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
      if elements = pull
        source = @source
        elements.each do |el|
          file_base64 = File.join(@root_path, el[:converted_path])
          file_ext = el[:converted_path].split('.').last
          begin
            next if File.size?(file_base64) > @img_max_size
            file_base64 = self.class.file_to_base64(file_base64)
            source.gsub!(el[:original_url], "url(data:image/#{file_ext.downcase};base64,#{file_base64})")
          rescue
            next
          end
        end
        @result = source
      else
        @result = @source
      end
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

    # Convert to base64 without new lines
    def self.file_to_base64(path)
      str = File.open(path, 'r') { |file| file.read }
      Base64.encode64(str).gsub("\n", '')
    end

    private

    # Pulls out files paths from url(smthng)
    # Returns an array containing:
    # - original path  (./images/smthng.png)
    # - converted path (/images/smthng.png)
    # - original url   (url(./images/smthng.png))
    def pull
      # Whole urls including  stuff around (url('/images/smthng.png') )
      whole_urls = @source.scan(/url\(.+?\)/i)
      return nil if whole_urls.count == 0

      img_bg_paths = []
      whole_urls.each do |url|
        img_bg_paths << url.scan(/url\(\s*["']?([^"']+)["']?\s*\)/i)[0][0]
      end
      img_bg_paths_original = img_bg_paths.clone

      img_bg_paths.collect! do |img|
        img = img.gsub('./', '/')
        img = "/#{img}" if img[0] != '/'
        img
      end

      result = []
      img_bg_paths.each_with_index do |el, i|
        result <<
          {:original_path =>img_bg_paths_original[i],
          :converted_path => el,
          :original_url => whole_urls[i]
          }
      end
      result.uniq!
      result
    end

  end
end
