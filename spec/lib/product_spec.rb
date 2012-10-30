# coding: utf-8
require 'spec_helper'

describe Taobao::Product do
  let(:product) do
    args = {
      method: 'taobao.item.get',
      fields: 'cid,num_iid,title,nick,price,pic_url,type,score,delist_time,' +
              'post_fee,volume,detail_url,seller_cids,props,input_pids,' +
              'input_str,desc,num,valid_thru,list_time,stuff_status,' +
              'location,express_fee,ems_fee,has_discount,freight_payer,' +
              'has_invoice,has_warranty,has_showcase,modified,increment,' +
              'approve_status,postage_id,product_id,auction_point,' +
              'property_alias,item_img,prop_img,sku,video,outer_id,is_virtual,' +
              'sell_promise,second_kill,auto_fill,props_name',
      num_iid: '2997802325'
    }
    fixture = 'product'.json_fixture
    Taobao.stub(:api_request).with(args).and_return(fixture)
    Taobao::Product.new(2997802325)
  end
  subject { product }

  describe 'initialize with id' do
    it 'should returns product' do
      subject.cid.should == 1512
      subject.nick.should == '奇迹shouji'
      subject.num_iid.should == 2997802325
      subject.pic_url.should == 'http://img03.taobaocdn.com/bao/uploaded/i3/T1YsfeXbxkXXXpZak._110941.jpg'
      subject.price.should == 4300.00
      subject.title.should == '可完美越狱 Apple/苹果 iPhone 4S 正品 装软件 未拆封 未激活'

      subject.approve_status.should == 'onsale'
      subject.auction_point.should == 0
      subject.delist_time.should == '2012-06-01 22:41:44'
      subject.type.should == 'fixed'
    end

    describe 'get unknown product property' do
      it do
        expect {
          subject.unknown_property
        }.to raise_error NoMethodError
      end
    end
  end

  its(:user) { should be_a_kind_of Taobao::User }
end