# Css image embedder engine - used to embed images into CSS files
module CssImageEmbedder
  class Engine

    EXTRACT_REGEXP = /url\(.+?\)/i

    # @param [String] root of imgs position - this needs to be an absolute
    #   path, so we need to join it with Rails.root if we use Rails
    # @param [Integer] maximum file size (in kb) - bigger will not be embedded
    # @return [CssImageEmbedder::Engine] instance
    # @example
    #   CssImageEmbedder::Engine.new(ASSET_IMAGE_LIMIT)
    #   CssImageEmbedder::Engine.new
    def initialize(img_max_size = 32)
      @image_root = File.join(Rails.root, 'app')
      @image_max_size = img_max_size*1024
    end

    # @param [String] content of a CSS file in which we want to embed pictures
    # @return [String] content of a CSS file with embedded pictures
    # @example
    #   engine.compress(@css_content)
    def compress(css)
      images(css).each do |image|
        begin
          next if File.size?(image.file_path) > @image_max_size
          css.gsub!(image.css_url, "url(data:image/#{image.ext};base64,#{image.to_base64})")
        rescue
          next
        end
      end
      css
    end

    private

    # Extracts all the images paths from input CSS string. It extracts
    # CSS urls with a regular expression
    # 
    # @param [String] CSS input content (css file content)
    # @return [Array<CssImageEmbedder::Image>] returns all the images that
    #   were used in given css file.
    def images(css)
      css.scan(EXTRACT_REGEXP).collect { |img| Image.new(img, @image_root) }
    end

  end
end
