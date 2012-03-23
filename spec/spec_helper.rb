require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

require 'taobao'
