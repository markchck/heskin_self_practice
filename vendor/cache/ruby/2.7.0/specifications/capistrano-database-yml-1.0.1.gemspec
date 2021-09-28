# -*- encoding: utf-8 -*-
# stub: capistrano-database-yml 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-database-yml".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shimpei Otsubo".freeze]
  s.date = "2016-07-14"
  s.description = "Capistrano tasks for automating `database.yml` file handling for Rails 4+ apps.\nThis plugins syncs contents of your local database file and copies that to\nthe remote server.\n".freeze
  s.email = ["potsbo@gmail.com".freeze]
  s.homepage = "https://github.com/capistrano-plugins/capistrano-database-yml".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Capistrano tasks for automating `database.yml` file handling for Rails 4+ apps.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capistrano>.freeze, [">= 3.1"])
    s.add_runtime_dependency(%q<sshkit>.freeze, [">= 1.2.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<capistrano>.freeze, [">= 3.1"])
    s.add_dependency(%q<sshkit>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
