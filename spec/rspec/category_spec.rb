# coding: utf-8
require 'spec_helper'

describe Taobao::Category do

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
        .should raise_error Taobao::IncorrectCategoryId, 'Incorrect category ID'
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
  
  describe 'properties' do
    it 'should return empty array for top level category' do
      category = Taobao::Category.new(0)
      fixture = 'top_category_properties.json'.json_fixture
      args = {
        method: 'taobao.itemprops.get',
        fields: 'pid,name,must,multi,prop_values',
        cid: 0
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      
      category.properties.should == []
    end
    it 'should return a few properties' do
      category = Taobao::Category.new(50005718)
      
      fixture = 'category_properties.json'.json_fixture
      args = {
        method: 'taobao.itemprops.get',
        fields: 'pid,name,must,multi,prop_values',
        cid: 50005718
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      
      category.properties.size.should be > 0
    end
  end
  
  describe 'products' do
    it 'should return ProductList object' do
      category = Taobao::Category.new(28)
      category.products.class.should == Taobao::ProductList
    end
  end
end   