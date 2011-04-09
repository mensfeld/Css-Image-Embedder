# CSS Image Embedder

Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).

## INSTALL
  
    gem install css_image_embedder

# USAGE

Add gem to your gemfile:

    gem 'css_image_embedder'

and then you will gain a helper method called `image_embed_stylesheet_link_tag`. Use it instead of `stylesheet_link_tag` (params are the same). This helper method will not destroy (or modify) your original CSS files. It only changes cached CSS file, so if you do not use:

    :cache => "/path/cached_stylesheets.css"

method will act the same way as `stylesheet_link_tag`. Also - you will not see any effect in development environment (except when you turn caching on).

## Disadvantages

Css Image Embedder has one major disadvantage. Files converted into base64 are approximately 30% bigger then normal, so when you embed them into CSS file, the total size of CSS with backgrounds will not be equal to sum of CSS file and backgrounds files. However, if you use gzip compression on your server - it will compress CSS file and the total size will be approximately equal. So just turn gzip compression on :)
## Example

Suppose we have two backgrounds: `bg1.png` and `bg2.jpg` and two CSS files (each for background declaration): `first.css` and `second.css`. 

The background declarations will be normal. You don't need to do anything special in your CSS files. So lets take `first.css`:

    #first { background: #fff url(/images/bg1.png) no-repeat;}

and second stylesheet:

    #second { background: #fff url(/images/bg2.png) no-repeat;}

Now lets just use them in our layout:

    image_embed_stylesheet_link_tag(
      "first", "second",
      :cache => "cached_stylesheet"
    )
    
This will produce nice `cached_stylesheet` with both background images embedded directly into cached CSS file.


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.
