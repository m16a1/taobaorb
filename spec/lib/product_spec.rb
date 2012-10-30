# coding: utf-8
require 'spec_helper'

describe Taobao::Product do
  before(:each) do
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
    @product = Taobao::Product.new(2997802325)
  end

  describe 'initialize with id' do
    it 'should returns product' do
      @product.cid.should == 1512
      @product.nick.should == '奇迹shouji'
      @product.num_iid.should == 2997802325
      @product.pic_url.should == 'http://img03.taobaocdn.com/bao/uploaded/i3/T1YsfeXbxkXXXpZak._110941.jpg'
      @product.price.should == 4300.00
      @product.title.should == '可完美越狱 Apple/苹果 iPhone 4S 正品 装软件 未拆封 未激活'

      @product.approve_status.should == 'onsale'
      @product.auction_point.should == 0
      @product.delist_time.should == '2012-06-01 22:41:44'
      @product.type.should == 'fixed'
    end

    describe 'get unknown product property' do
      it 'should raise an exception' do
        expect {
          @product.unknown_property
        }.to raise_error NoMethodError
      end
    end
  end

  describe '#user' do
    it 'should returns Taobao::User object' do
      @product.user.should be_a_kind_of Taobao::User
    end
  end
end