# -*- encoding: utf-8 -*-
# stub: pry-nav 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-nav"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Gopal Patel"]
  s.date = "2012-07-14"
  s.description = "Turn Pry into a primitive debugger. Adds 'step' and 'next' commands to control execution."
  s.email = "nixme@stillhope.com"
  s.homepage = "https://github.com/nixme/pry-nav"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "2.2.5"
  s.summary = "Simple execution navigation for Pry."

  s.installed_by_version = "2.2.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pry>, ["~> 0.9.10"])
      s.add_development_dependency(%q<pry-remote>, ["~> 0.1.1"])
    else
      s.add_dependency(%q<pry>, ["~> 0.9.10"])
      s.add_dependency(%q<pry-remote>, ["~> 0.1.1"])
    end
  else
    s.add_dependency(%q<pry>, ["~> 0.9.10"])
    s.add_dependency(%q<pry-remote>, ["~> 0.1.1"])
  end
end
