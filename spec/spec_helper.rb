require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

require 'taobaorb'

class String
  def str_fixture
    open("spec/fixtures/#{self}").read
  end
  
  def json_fixture
    contents = open("spec/fixtures/#{self}").read
    JSON.parse contents, {symbolize_names: true}
  end
end