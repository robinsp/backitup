# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{backitup}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Spainhour"]
  s.date = %q{2009-05-28}
  s.default_executable = %q{backitup}
  s.description = %q{Simple backup tool}
  s.email = %q{robin@robinspainhour.com}
  s.executables = ["backitup"]
  s.extra_rdoc_files = ["bin/backitup", "lib/back_it_up.rb", "lib/back_it_up/config.rb", "lib/back_it_up/file_list.rb", "lib/back_it_up/file_packager.rb", "lib/back_it_up/command.rb", "lib/back_it_up/runner.rb", "README.rdoc"]
  s.files = ["bin/backitup", "sample.backitup", "spec/test-config.backitup", "spec/file_packager_spec.rb", "spec/config_spec.rb", "spec/runner_spec.rb", "spec/file_list_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "Rakefile", "lib/back_it_up.rb", "lib/back_it_up/config.rb", "lib/back_it_up/file_list.rb", "lib/back_it_up/file_packager.rb", "lib/back_it_up/command.rb", "lib/back_it_up/runner.rb", "README.rdoc", "Manifest", "backitup.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/robinsp/backitup}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Backitup", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{backitup}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Simple backup tool}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
    else
      s.add_dependency(%q<rubyzip>, [">= 0"])
    end
  else
    s.add_dependency(%q<rubyzip>, [">= 0"])
  end
end
