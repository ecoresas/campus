# -*- encoding: utf-8 -*-
# stub: ampex 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ampex"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Conrad Irwin"]
  s.date = "2012-05-20"
  s.description = "Why would you want to write { |x| x['one'] } when you can write &X['one'], why indeed."
  s.email = "conrad.irwin@gmail.com"
  s.homepage = "http://github.com/rapportive-oss/ampex"
  s.rubygems_version = "2.2.5"
  s.summary = "Provides a meta-variable X which can be used to create procs more prettily"

  s.installed_by_version = "2.2.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<blankslate>, [">= 0"])
    else
      s.add_dependency(%q<blankslate>, [">= 0"])
    end
  else
    s.add_dependency(%q<blankslate>, [">= 0"])
  end
end
