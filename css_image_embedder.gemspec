# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "css_image_embedder"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = "2013-05-25"
  s.description = "Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once)."
  s.email = "maciej@mensfeld.pl"
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/css_image_embedder.rb", "lib/css_image_embedder/compressor.rb", "lib/css_image_embedder/engine.rb", "lib/css_image_embedder/image.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "LICENCE", "README.md", "Rakefile", "init.rb", "lib/css_image_embedder.rb", "lib/css_image_embedder/compressor.rb", "lib/css_image_embedder/engine.rb", "lib/css_image_embedder/image.rb", "spec/app/assets/images/bg.png", "spec/app/assets/images/bg_base64.png", "spec/app/assets/images/too_big.jpg", "spec/app/assets/stylesheets/big_converted.css", "spec/app/assets/stylesheets/file_sources_invalid.css", "spec/app/assets/stylesheets/oneliner.css", "spec/app/assets/stylesheets/oneliner_converted.css", "spec/app/assets/stylesheets/std.css", "spec/app/assets/stylesheets/std_converted.css", "spec/app/assets/stylesheets/too_big.css", "spec/compressor_spec.rb", "spec/engine_spec.rb", "spec/image_spec.rb", "spec/spec_helper.rb", "Manifest", "css_image_embedder.gemspec"]
  s.homepage = "https://github.com/mensfeld/Css-Image-Embedder"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Css_image_embedder", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "css_image_embedder"
  s.rubygems_version = "1.8.24"
  s.summary = "Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once)."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<sass>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<sass>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end
