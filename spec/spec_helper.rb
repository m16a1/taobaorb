require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

require 'taobaorb'

Response = Struct.new('Responce', :body)

class String
  def to_response
    Response.new get_fixture_as_text
  end

  def xml_fixture
    Nokogiri::XML(get_fixture_as_text).to_symbolized_hash
  end

  private
  def get_fixture_as_text
    open("spec/fixtures/#{self}.xml").read
  end
end