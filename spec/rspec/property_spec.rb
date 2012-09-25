# coding: utf-8
require 'spec_helper'

describe Taobao::Property do
  describe 'initialize' do
    describe 'with correct data' do
      it 'should create Property object' do
        property_response = 'property'.json_fixture
        property = Taobao::Property.new(property_response)

        property.multi.should be_false
        property.must.should be_true
        property.name.should == "品牌"
        property.pid.should == 20000
        property.values.should be_a_kind_of Array
        property.values.should have_exactly(2).items

        value = property.values.first
        value[:is_parent].should be_true
        value[:name].should == "Acer/宏基"
        value[:vid].should == 26691
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