# Css Image Embedder connected with SASS CSS compressor
# Used to minimize CSS and then embed into it base64 images

require 'sass'

module CssImageEmbedder
  class Compressor

    # @param [Integer] max image size that will be embedded (in KB)
    # @return [CssImageEmbedder::Compressor] compressor instance
    def initialize(img_max_size = 32)
      @engine = CssImageEmbedder::Engine.new(img_max_size)
    end

    # Compress given CSS/SCSS file and embed into it images
    # @params [String] CSS/SCSS input
    # @return [String] CSS file content with embedded images
    def compress(string)
      sass = Sass::Engine.new(string, syntax: :scss, style: :compressed)
      @engine.compress(sass.render)
    end
  end
end
