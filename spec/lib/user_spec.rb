# coding: utf-8
require 'spec_helper'

describe Taobao::User do
  args = {
    method: 'taobao.user.get',
    fields: 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,' +
      'created,last_visit,birthday,type,status,alipay_no,alipay_account,'+
      'alipay_account,email,consumer_protection,alipay_bind'
  }

  context 'valid user' do
    let(:fixture) { 'user'.json_fixture }
    let(:user) do
      args[:nick] = '喜客多2008'
      Taobao.stub(:api_request).with(args).and_return fixture
      Taobao::User.new('喜客多2008')
    end

    it 'should returns valid user info' do
      user.nick.should == '喜客多2008'
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

  context 'user who does not specify his/her sex' do
    let(:fixture) { 'user_unknown_sex'.json_fixture }
    subject do
      args[:nick] = 't400旗舰店'
      Taobao.stub(:api_request).with(args).and_return fixture
      Taobao::User.new('t400旗舰店')
    end
    its(:sex) { should == :unknown }
  end

  context 'non-existent user' do
    let(:fixture) { 'absent_user'.json_fixture }
    before do
      args[:nick] = 'nonexistent_user'
      Taobao.stub(:api_request).with(args).and_return fixture
    end
    it do
      expect { Taobao::User.new('nonexistent_user').uid }
        .to raise_error NoMethodError
    end
  end
end