require 'rspec'
require 'simplecov'
require 'mocha'

SimpleCov.start do
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

require 'taobao'

class String
	def json_fixture
		contents = open("spec/fixtures/#{self}").read
		JSON.parse contents, {symbolize_names: true}
	end
end