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
      Taobao.method_defined?(:private_key).should == false
    end
  end
end