# coding: utf-8
require 'spec_helper'

describe Taobao::Category do
  before(:each) do
    Taobao.public_key  = 'test'
    Taobao.private_key = 'test'
  end

  it 'should have name' do
    Taobao.expects(:api_request).returns('category.json'.json_fixture)
    
    category = Taobao::Category.new(28)
    category.id.should  == 28
    category.name.should == 'ZIPPO/瑞士军刀/眼镜'
  end

  describe 'with incorrect id' do
    it 'should throws an exception' do
      fixture = 'incorrect_category.json'.json_fixture
      args = {
        method: 'taobao.itemcats.get',
        fields: 'cid,parent_cid,name,is_parent',
        cid: -20
      }
      Taobao.expects(:api_request).with(args).returns(fixture)

      lambda {Taobao::Category.new(-20)}
        .should raise_error Taobao::ApiError, 'Incorrect category ID'
    end
  end

# describe 'subcategories' do
#   it 'top level category (id = 0) should have contains a few subcategories' do
#     fixture = open('spec/fixtures/subcategories.json').read
#     response = double('Response')
#     response.should_receive(:body).and_return(fixture)
#     Net::HTTP.should_receive(:post_form).and_return(response)
#     
#     root_category = Taobao::Category.new(0)
#     category.subcategories.size.should be > 0
#   end
# end
end   