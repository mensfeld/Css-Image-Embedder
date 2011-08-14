# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{css_image_embedder}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Maciej Mensfeld}]
  s.date = %q{2011-08-14}
  s.description = %q{Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{README.md}, %q{lib/css_image_embedder.rb}, %q{lib/css_image_embedder/compressor.rb}, %q{lib/css_image_embedder/converter.rb}, %q{lib/css_image_embedder/engine.rb}, %q{lib/css_image_embedder/exception.rb}, %q{lib/css_image_embedder/helper.rb}]
  s.files = [%q{CHANGELOG.rdoc}, %q{Gemfile}, %q{LICENCE}, %q{README.md}, %q{Rakefile}, %q{css_image_embedder.gemspec}, %q{init.rb}, %q{lib/css_image_embedder.rb}, %q{lib/css_image_embedder/compressor.rb}, %q{lib/css_image_embedder/converter.rb}, %q{lib/css_image_embedder/engine.rb}, %q{lib/css_image_embedder/exception.rb}, %q{lib/css_image_embedder/helper.rb}, %q{spec/css_image_embedder_spec.rb}, %q{spec/files/bg.png}, %q{spec/files/bg_base64.png}, %q{spec/files/big_converted.css}, %q{spec/files/file_sources_invalid.css}, %q{spec/files/oneliner.css}, %q{spec/files/oneliner_converted.css}, %q{spec/files/std.css}, %q{spec/files/std_converted.css}, %q{spec/files/too_big.css}, %q{spec/files/too_big.jpg}, %q{spec/spec_helper.rb}, %q{Manifest}]
  s.homepage = %q{https://github.com/mensfeld/Css-Image-Embedder}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Css_image_embedder}, %q{--main}, %q{README.md}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{css_image_embedder}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
    else
      s.add_dependency(%q<sass>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<sass>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<rails>, [">= 0"])
  end
end
