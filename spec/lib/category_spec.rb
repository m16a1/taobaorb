# coding: utf-8
require 'spec_helper'

describe Taobao::Category do
  describe '#id' do
    it 'should returns ID of the category' do
      category = Taobao::Category.new(28)
      category.id.should  == 28
    end
  end
  describe '#name' do
    args = {
      method: 'taobao.itemcats.get',
      fields: 'cid,parent_cid,name,is_parent',
      cids: 28
    }
    it 'should returns the name of the category' do
      category = Taobao::Category.new(28)
      fixture = 'category'.json_fixture
      Taobao.stub(:api_request).with(args).and_return(fixture)
      category.name.should == 'ZIPPO/瑞士军刀/眼镜'
    end
    it 'should throws an exception if the category ID is incorrect' do
      Net::HTTP.stub(:post_form).and_return 'incorrect_category'.to_response
      category = Taobao::Category.new(-20)
      expect {
        category.name
      }.to raise_error Taobao::ApiError, 'Invalid arguments:cids'
    end
  end

  describe '#subcategories' do
    before :each do
      @category = Taobao::Category.new(28)
    end
    it 'should returns subcategories if they are exists' do
      Taobao.stub(:api_request).and_return 'subcategories'.json_fixture
      @category.subcategories.should have_at_least(1).subcategory
    end
    it 'should returns empty array if subcategories do not exist' do
      Taobao.stub(:api_request).and_return 'category_without_subcategories'.json_fixture
      @category.subcategories.should be_empty
    end
    it 'each subcategory should be an object of Taobao::Category class' do
      Taobao.stub(:api_request).and_return 'subcategories'.json_fixture
      @category.subcategories[0].should be_a_kind_of(Taobao::Category)
      @category.subcategories[0].id.should be > 0
    end
  end

  let(:category) { Taobao::Category.new(0) }
  subject { category }
  its(:properties) { should be_a_kind_of Taobao::PropertyList }
  its(:products) { should be_a_kind_of Taobao::ProductList }
end