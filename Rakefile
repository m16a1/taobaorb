require 'bundler'
Bundler.setup

require 'rake'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'taobao/version'

task :gem => :build
task :build do
  system 'gem build taobaorb.gemspec'
end

task :install => :build do
  system "sudo gem install taobaorb-#{Taobao::VERSION}.gem"
end

task :clean do
  system 'rm -rf ./coverage/*'
  system 'rmdir ./coverage'
  system 'rm *.gem'
end

task :release => :build do
  system "git tag -a v#{Taobao::VERSION} -m 'Tagging #{Taobao::VERSION}'"
  system "git push --tags"
  system "gem push taobaorb-#{Taobao::VERSION}.gem"
  system "rm taobaorb-#{Taobao::VERSION}.gem"
end

RSpec::Core::RakeTask.new('spec') do |spec|
  spec.rspec_opts = %w(--format d --color --profile)
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec