require 'base64'

# Image model that represents single image that we want to embed
module CssImageEmbedder
  class Image

    # Regular expression used to extract only the url itself
    URL_REGEXP = /url\(\s*["']?([^"']+)["']?\s*\)/i

    # @param [String] original css url ("url('./something/etc')")
    # @param [String] file root
    # @return [CssImageEmbedder::Image] image instance
    def initialize(css_url, root)
      @css_url = css_url
      @root = root
      @url = css_url.scan(URL_REGEXP)[0][0]
    end

    # @return [String] original CSS url string
    def css_url
      @css_url
    end

    # @return [String] pure url (without CSS stuff)
    # @example
    #   image.url #=> './something/picture.png'
    def url
      @url
    end

    # @return [String] absolute path to a given picture
    # @example
    #   image.file_path #=> '/var/www/app/assets/images/picture.jpg'
    def file_path
      path = url.gsub('./', '/')
      path = "/#{path}" if path[0] != '/'
      File.join(@root, path.gsub('assets/', 'assets/images/'))
    end

    # @return [String] downcased file extension
    # @example
    #   image.ext #=> 'jpg'
    def ext
      splitted = file_path.split('.')
      splitted.length > 1 ? splitted.last.downcase : ''
    end

    # @return [String] bse64 converted picture
    # @example
    #   image.to_base64 #=> base64 content
    def to_base64
      str = File.open(file_path, 'r') { |file| file.read }
      Base64.encode64(str).gsub("\n", '')
    end

  end
end
