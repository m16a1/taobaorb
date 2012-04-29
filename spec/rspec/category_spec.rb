# coding: utf-8
require 'spec_helper'

describe Taobao::Category do
  before(:each) do
    Taobao.public_key  = 'test'
    Taobao.private_key = 'test'
  end

  it 'should have name' do
    category = Taobao::Category.new(28)
    category.id.should  == 28
    
    fixture = 'category.json'.json_fixture
    args = {
      method: 'taobao.itemcats.get',
      fields: 'cid,parent_cid,name,is_parent',
      cids: 28
    }
    Taobao.stub(:api_request).with(args).and_return(fixture)
    
    category.name.should == 'ZIPPO/瑞士军刀/眼镜'
  end

  describe 'with incorrect id' do
    it 'should throws an exception' do
      fixture = 'incorrect_category.json'.json_fixture
      args = {
        method: 'taobao.itemcats.get',
        fields: 'cid,parent_cid,name,is_parent',
        cids: -20
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      category = Taobao::Category.new(-20)
      lambda {category.name}
        .should raise_error Taobao::ApiError, 'Incorrect category ID'
    end
  end

  describe 'subcategories' do
    it 'top level category should contains a few subcategories' do

      category = Taobao::Category.new(28)
      fixture = 'subcategories.json'.json_fixture
      args = {
        method: 'taobao.itemcats.get',
        fields: 'cid,parent_cid,name,is_parent',
        parent_cid: 28
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      category.subcategories.size.should be > 0
    end
  end
  
#  describe 'properties' do
#    it 'shold returns a few properties' do
#      category = Taobao::Category.new(50005718)
#      category.properties.size.should be > 0
#    end
#  end
end   