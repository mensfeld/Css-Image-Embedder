# CSS Image Embedder

Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to this - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).

## INSTALL
  
    gem install css_image_embedder

# USAGE

## Ruby on Rails 3.1 and 3.2

In environments/production.rb:

    config.assets.css_compressor = CssImageEmbedder::Compressor.new

## Disadvantages

Css Image Embedder has one major disadvantage. Files converted into base64 are approximately 30% bigger then normal, so when you embed them into CSS file, the total size of CSS with backgrounds will not be equal to sum of CSS file and backgrounds files. However, if you use gzip compression on your server - it will compress CSS file and the total size will be approximately equal. So just turn gzip compression on :)

## Example

We set up CssImageEmbedder::Compressor as a css compressor and... thats all :)

    config.assets.css_compressor = CssImageEmbedder::Compressor.new

## Tests

    bundle exec rspec spec/

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Maciej Mensfeld. See LICENSE for details.
