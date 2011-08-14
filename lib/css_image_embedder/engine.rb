require 'base64'

# Css image embedder engine - used to embed images into CSS
module CssImageEmbedder
  class Engine

    # img_root - root of imgs position ( public/ in Rails)
    # img_max_size - maximum file size (in kb) - bigger will not be embedded
    def initialize(img_root, img_max_size = 32)
      @img_root = img_root
      @img_max_size = img_max_size*1024
    end

    def compress(string)
      if elements = pull(string)
        source = string
        elements.each do |el|
          file_base64 = File.join(@img_root, el[:converted_path])
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
        @result = string
      end
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
    def pull(css)
      # Whole urls including  stuff around (url('/images/smthng.png') )
      whole_urls = css.scan(/url\(.+?\)/i)
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