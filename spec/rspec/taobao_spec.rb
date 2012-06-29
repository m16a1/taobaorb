require 'spec_helper'

Response = Struct.new('Responce', :body)

describe Taobao do
  describe 'set the public API key' do
    it 'should have rw access' do
      Taobao.public_key = :test
      Taobao.public_key.should == :test
    end
  end
  describe 'set the private API key' do
    it 'should be write-only' do
      Taobao.private_key = :test
      Taobao.method_defined?(:private_key).should == false
    end
  end
  describe 'API request' do
    it 'should always return a Hash object' do
      fixture = Response.new('category.json'.str_fixture)
      Net::HTTP.stub(:post_form).and_return(fixture)
      result = Taobao.api_request(method: 'taobao.itemcats.get',
        fields: 'cid,parent_cid,name,is_parent', cids: 0)
      result.class.should == Hash
    end
  end
  describe 'failed API request' do
    it 'should throws an exception' do
      fixture = Response.new('error.json'.str_fixture)
      Net::HTTP.stub(:post_form).and_return(fixture)
      lambda { Taobao.api_request({}) }
        .should raise_error Taobao::ApiError, 'Invalid arguments:cid'
    end
  end
end