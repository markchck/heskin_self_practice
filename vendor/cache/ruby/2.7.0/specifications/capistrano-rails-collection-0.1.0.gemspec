# -*- encoding: utf-8 -*-
# stub: capistrano-rails-collection 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-rails-collection".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["dei79".freeze]
  s.date = "2016-10-17"
  s.description = "Rails specific Capistrano tasks which are not part of the official rails gem".freeze
  s.email = ["dirk.eisenberg@gmail.com".freeze]
  s.homepage = "https://github.com/dei79/capistrano-rails-collection".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Rails specific Capistrano tasks which are not part of the official rails gem".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capistrano-rails>.freeze, ["~> 1.1"])
  else
    s.add_dependency(%q<capistrano-rails>.freeze, ["~> 1.1"])
  end
end
