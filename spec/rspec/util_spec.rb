# coding: utf-8
require 'spec_helper'

class ToObjectTest
  attr_reader :a, :b
  include Taobao::Util
end

describe Taobao::Util do
  describe 'to_object' do
    it 'should convert some hash to object' do
      obj = ToObjectTest.new
      obj.to_object a: 5, b: 6
      obj.a.should == 5
      obj.b.should == 6
    end
  end
end