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
      expect {
        category.name
      }.to raise_error Taobao::IncorrectCategoryId, 'Incorrect category ID'
    end
  end

  describe 'subcategories' do
    category = Taobao::Category.new(28)

    fixture = 'subcategories.json'.json_fixture
    args = {
      method: 'taobao.itemcats.get',
      fields: 'cid,parent_cid,name,is_parent',
      parent_cid: 28
    }
    it 'top level category should contains a few subcategories' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      category.subcategories.should have_at_least(1).subcategory
    end
    it 'each subcategory must be an object of Taobao::Category class' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      category.subcategories[0].should be_a_kind_of(Taobao::Category)
    end
  end

  describe 'properties' do
    it 'should return empty array for top level category' do
      category = Taobao::Category.new(0)
     category.properties.should be_a_kind_of(Taobao::PropertyList)
    end
  end

  describe 'products' do
    it 'should return ProductList object' do
      category = Taobao::Category.new(28)
      category.products.should be_a_kind_of(Taobao::ProductList)
    end
  end
end