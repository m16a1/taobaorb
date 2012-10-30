# coding: utf-8
require 'spec_helper'

describe Taobao::User do
  let(:valid_user) do
    args = {
      method: 'taobao.user.get',
      fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
        'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
        'alipay_account,email,consumer_protection,alipay_bind',
      nick: '喜客多2008'
    }
    Taobao.stub(:api_request).with(args).and_return 'user'.json_fixture
    user = Taobao::User.new('喜客多2008')
  end

  describe '#nick' do
    it "return user's nickname" do
      valid_user.nick.should == '喜客多2008'
    end
  end

  describe '#good_purchases_count' do
    it 'return count of purchases with good rating' do
      valid_user.good_purchases_count.should == 1292
    end
  end

  describe '#buyer_level' do
    it 'return buyer level' do
      valid_user.buyer_level.should == 8
    end
  end

  describe '#buyer_score' do
    it 'return buyer score' do
      valid_user.buyer_score.should == 1292
    end
  end

  describe 'total_purchases_count' do
    it 'should ' do
      valid_user.total_purchases_count.should == 1292
    end
  end

=begin
  describe 'getting user by valid nickname' do
    it 'should returns valid user info' do
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
=end
  describe 'getting user who does not specify his/her sex' do
    it 'should returns :unknown value' do
      fixture = 'user_unknown_sex'.json_fixture
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
      fixture = 'absent_user'.json_fixture
      args = {
        method: 'taobao.user.get',
        fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
          'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
          'alipay_account,email,consumer_protection,alipay_bind',
        nick: 'nonexistent_user'
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)

      expect { Taobao::User.new('nonexistent_user').uid }
        .to raise_error NoMethodError
    end
  end
end