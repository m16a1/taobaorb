require 'spec_helper'

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
      expect { Taobao.private_key }
        .to raise_error NoMethodError
    end
  end
  describe 'API request' do
    it 'should always return a Hash object' do
      Net::HTTP.stub(:post_form).and_return 'category'.to_response
      result = Taobao.api_request(method: 'taobao.itemcats.get',
        fields: 'cid,parent_cid,name,is_parent', cids: 0)
      result.should be_a_kind_of(Hash)
    end
  end
  describe 'failed API request' do
    it 'should throws an exception' do
      Net::HTTP.stub(:post_form).and_return 'error'.to_response
      expect { Taobao.api_request({}) }
        .to raise_error(Taobao::ApiError, 'Invalid arguments:cid')
    end
  end
end