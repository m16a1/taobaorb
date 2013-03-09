# coding: utf-8
require 'spec_helper'

describe Taobao::PropertyList do
  describe 'initialize with category ID' do

    it 'should returns property' do
      property_list = Taobao::PropertyList.new(cid: 1512)

      fixture = 'category_properties'.xml_fixture
      args = {
        method: 'taobao.itemprops.get',
        fields: 'pid,name,prop_values,must,multi,is_color_prop,is_key_prop,is_enum_prop,is_input_prop,is_sale_prop,is_item_prop',
        cid: 1512
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      property_list.first.should be_a_kind_of(Taobao::Property)
    end
  end

 describe 'category without properties' do

    it 'should returns 0 properties' do
      property_list = Taobao::PropertyList.new(cid: 0)

      fixture = 'top_category_properties'.xml_fixture
      args = {
        method: 'taobao.itemprops.get',
        fields: 'pid,name,prop_values,must,multi,is_color_prop,is_key_prop,is_enum_prop,is_input_prop,is_sale_prop,is_item_prop',
        cid: 0
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      property_list.should have(0).items
    end
  end

end