# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{webify}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Slattery"]
  s.date = %q{2010-02-22}
  s.default_executable = %q{webify}
  s.description = %q{Turn a directory of Markdown files into HTML}
  s.email = %q{kyle@kyleslattery.com}
  s.executables = ["webify"]
  s.extra_rdoc_files = ["README.md", "bin/webify", "lib/webify.rb", "lib/webify/builder.rb", "lib/webify/file.rb"]
  s.files = ["Manifest", "README.md", "Rakefile", "bin/webify", "lib/webify.rb", "lib/webify/builder.rb", "lib/webify/file.rb", "spec/builder_spec.rb", "spec/file_spec.rb", "template.erb", "webify.gemspec"]
  s.homepage = %q{http://github.com/kyleslattery/webify}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Webify", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{webify}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Turn a directory of Markdown files into HTML}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rdiscount>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rdiscount>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rdiscount>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
