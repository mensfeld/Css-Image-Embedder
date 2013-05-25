$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'fileutils'
require 'action_view'

class Rails
  def self.root
    File.expand_path(File.dirname(__FILE__))
  end

  def self.app
    File.join(root, 'app')
  end
end

def file_content(f)
  file = File.new("#{f}", "r")
  content = ''
  while (line = file.gets)
    content+=line
  end
  content
end

def css_content(name)
  file_content("#{Rails.app}/assets/stylesheets/#{name}.css")
end

def files_equal?(f1, f2)
  file_content(f1) == file_content(f2)
end

require 'css_image_embedder'
