# coding: utf-8
require 'spec_helper'

describe Taobao::Property do
  describe 'initialize' do
    describe 'with correct data' do
      it 'should create Property object' do
        property_response = 'property'.xml_fixture
        property = Taobao::Property.new(property_response[:itemprops_get_response][:item_props][:item_prop])

        property.multi.should be_false
        property.must.should be_true
        property.name.should == "品牌"
        property.pid.should == 20000
        property.values.should be_a_kind_of Array
        property.values.should have_exactly(254).items

        value = property.values.first
        value[:is_parent].should be_true
        value[:name].should == '17VEE'
        value[:vid].should == 100693056
      end
    end

    describe 'with incorrect data' do
      it 'should throws an exception' do
        expect { Taobao::Property.new({}) }
          .to raise_error(Taobao::IncorrectProperty, 'Incorrect property data')
      end
    end
  end
end