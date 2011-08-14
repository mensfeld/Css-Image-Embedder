# Helper methods for ActionView::Base in Rails
module CssImageEmbedder
  
  module Helper

    if Rails.version.to_s.include?('3.0')
      # Basicly it's just stylesheet_link_tag with one small difference ;)
      # Will not test it - Rails guys already did it
      def image_embed_stylesheet_link_tag(*sources)
        options = sources.extract_options!.stringify_keys
        concat  = options.delete("concat")
        cache   = concat || options.delete("cache")
        recursive = options.delete("recursive")
        root = options.delete("root") || File.join(Rails.root, 'public')
        env = options.delete("env") || Rails.env

        if concat || (config.perform_caching && cache)
          joined_stylesheet_name = (cache == true ? "all" : cache) + ".css"
          joined_stylesheet_path = File.join(joined_stylesheet_name[/^#{File::SEPARATOR}/] ? config.assets_dir : config.stylesheets_dir, joined_stylesheet_name)

          unless config.perform_caching && File.exists?(joined_stylesheet_path)
            write_asset_file_contents(joined_stylesheet_path, compute_stylesheet_paths(sources, recursive))
            # here's the magic ;)
            css = CssImageEmbedder::Converter.new(
              :path => joined_stylesheet_path,
              :overwrite => true,
              :root => root)
            css.convert
            css.save!
          end
          stylesheet_tag(joined_stylesheet_name, options)
        else
          sources = expand_stylesheet_sources(sources, recursive)
          # When we use SASS and test env - will not work - and will raise
          # exception - that css files does not exist. We make a workaround
          # by not checking sources in test env
          ensure_stylesheet_sources!(sources) if cache && env != 'test'
          sources.collect { |source| stylesheet_tag(source, options) }.join("\n").html_safe
        end
      end
    end
  end # Helper
  
end # Base64CssEmbedder

ActionView::Base.send :include, CssImageEmbedder::Helper
