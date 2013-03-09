require 'date'
require './lib/taobao/version'

Gem::Specification.new do |s|
  s.name                  = 'taobaorb'
  s.version               = Taobao::VERSION
  s.date                  = Date.today.to_s
  s.summary               = 'Ruby wrapper for the Taobao API'
  s.description           = <<-DESCR
    Ruby wrapper for the Taobao API uses XML
  DESCR
  s.authors               = ['m16a1']
  s.email                 = 'a741su@gmail.com'
  s.license               = 'MIT'
  s.has_rdoc              = true
  s.required_ruby_version = '>= 1.9'
  s.files                 = Dir['lib/**/*']
  s.homepage              = 'https://github.com/m16a1/taobaorb'
  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
end