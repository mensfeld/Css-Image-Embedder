# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{css_image_embedder}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.cert_chain = ["/home/mencio/.cert_keys/gem-public_cert.pem"]
  s.date = %q{2011-04-09}
  s.description = %q{Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/css_image_embedder.rb", "lib/css_image_embedder/converter.rb", "lib/css_image_embedder/exception.rb", "lib/css_image_embedder/helper.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "LICENCE", "README.md", "Rakefile", "init.rb", "lib/css_image_embedder.rb", "lib/css_image_embedder/converter.rb", "lib/css_image_embedder/exception.rb", "lib/css_image_embedder/helper.rb", "spec/css_image_embedder_spec.rb", "spec/files/bg.png", "spec/files/bg_base64.png", "spec/files/big_converted.css", "spec/files/file_sources_invalid.css", "spec/files/oneliner.css", "spec/files/oneliner_converted.css", "spec/files/std.css", "spec/files/std_converted.css", "spec/files/too_big.css", "spec/files/too_big.jpg", "spec/spec_helper.rb", "Manifest", "css_image_embedder.gemspec"]
  s.homepage = %q{http://github.com/mensfeld/css_image_embedder}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Css_image_embedder", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{css_image_embedder}
  s.rubygems_version = %q{1.5.2}
  s.signing_key = %q{/home/mencio/.cert_keys/gem-private_key.pem}
  s.summary = %q{Css Image Embedder puts your background files directly into corresponding CSS file. Thanks to that - your server needs to handle fewer requests and the page layout renders smoothly (whole stylesheet at once).}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<rails>, [">= 0"])
  end
end
