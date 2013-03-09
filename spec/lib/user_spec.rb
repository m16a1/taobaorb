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
    let(:fixture) { 'user'.xml_fixture }
    let(:user) do
      args[:nick] = '喜客多2008'
      Taobao.stub(:api_request).with(args).and_return fixture
      Taobao::User.new('喜客多2008')
    end

    it 'should returns valid user info' do
      user.nick.should == '喜客多2008'
      user.good_purchases_count.should == 1406
      user.buyer_level.should == 8
      user.buyer_score.should == 1406
      user.total_purchases_count.should == 1406
      user.good_sales_count.should == 4020434
      user.seller_level.should == 18
      user.seller_score.should == 4001996
      user.total_sales_count.should == 4083746
      user.registration_date.should == DateTime.new(2005,12,10, 19,03,18)
      user.last_visit.should == DateTime.new(2013,03,9, 14,05,56)
      user.city.should == '金华'
      user.state.should == '浙江'
      user.sex.should == :female
      user.type.should == 'C'
    end
  end

  context 'user who does not specify his/her' do
    let(:fixture) { 'user_unknown_sex'.xml_fixture }
    subject do
      args[:nick] = 't400旗舰店'
      Taobao.stub(:api_request).with(args).and_return fixture
      Taobao::User.new('t400旗舰店')
    end
    its(:sex) { should == :unknown }
  end

  context 'non-existent user' do
    let(:fixture) { 'absent_user'.xml_fixture }
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