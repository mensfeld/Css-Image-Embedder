# Css Image Embedder connected with SASS CSS compressor
# Used to minimize CSS and then embed into it base64 images

require 'sass'

module CssImageEmbedder
  class Compressor

    # img_root - root of imgs position ( public/ in Rails)
    # img_max_size - maximum file size (in kb) - bigger will not be embedded
    def initialize(img_root, img_max_size = 32)
      @img_root = img_root
      @img_max_size = img_max_size
    end

    def compress(string)
      engine = Sass::Engine.new(string, :syntax => :scss, :style => :compressed)
      CssImageEmbedder::Engine.new(@img_root, @img_max_size).compress(engine.render)
    end
  end
end