# coding: utf-8
require 'spec_helper'

describe Taobao::User do
  describe 'getting user by valid nickname' do
    it 'should returns valid user info' do
      fixture = 'user.json'.json_fixture
      args = {
        method: 'taobao.user.get',
        fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
          'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
          'alipay_account,email,consumer_protection,alipay_bind',
        nick: '喜客多2008'
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      
      user = Taobao::User.new('喜客多2008')
      
      user.good_purchases_count.should == 1292
      user.buyer_level.should == 8
      user.buyer_score.should == 1292
      user.total_purchases_count.should == 1292
      
      user.good_sales_count.should == 2587208
      user.seller_level.should == 18
      user.seller_score.should == 2576453
      user.total_sales_count.should == 2624203
      
      user.registration_date.should == DateTime.new(2005,12,10, 19,03,18)
      user.last_visit.should == DateTime.new(2012,06,29, 23,28,25)
      
      user.city.should == '金华'
      user.state.should == '浙江'
      
      user.sex.should == :female
      user.type.should == 'C'
      
      user.uid.should == '6cd6014f007c04426e2437fef870329a'
      user.id.should == 18139021
    end
  end
  describe 'getting user who does not specify his/her sex' do
    it 'should returns :unknown value' do
      fixture = 'user_unknown_sex.json'.json_fixture
      args = {
        method: 'taobao.user.get',
        fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
          'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
          'alipay_account,email,consumer_protection,alipay_bind',
        nick: 't400旗舰店'
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      user = Taobao::User.new('t400旗舰店')
      user.sex.should == :unknown
    end
  end
  
  describe 'getting non-existent user' do
    it 'should throws an exception' do
      fixture = 'absent_user.json'.json_fixture
      args = {
        method: 'taobao.user.get',
        fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
          'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
          'alipay_account,email,consumer_protection,alipay_bind',
        nick: 'nonexistent_user'
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      
      lambda { Taobao::User.new('nonexistent_user').uid }
        .should raise_error NoMethodError
    end
  end
end