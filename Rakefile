require 'psych'
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('css_image_embedder', '0.3.0') do |p|
  p.description    = "Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once)."
  p.url            = "https://github.com/mensfeld/Css-Image-Embedder"
  p.author         = "Maciej Mensfeld"
  p.email          = "maciej@mensfeld.pl"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ["rspec >=2.0.0"]
  p.dependencies = ["sass"]
end
