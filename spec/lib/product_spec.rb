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
    fixture = 'product'.xml_fixture
    Taobao.stub(:api_request).with(args).and_return(fixture)
    Taobao::Product.new(2997802325)
  end

  describe 'initialize with id' do
    it 'has category ID' do
      product.cid.should == 1512
    end
    it "has seller's nickname" do
      product.nick.should == '奇迹shouji'
    end
    it 'has item id' do
      product.num_iid.should == 2997802325
    end
    it 'has picture url' do
      product.pic_url.should == 'http://img01.taobaocdn.com/bao/uploaded/i1/T1XPLZXhJmXXXmXQ.0_035913.jpg'
    end
    it 'has product price' do
      product.price.should == 4530.00
    end
    it 'has product title' do
      product.title.should == 'Apple/苹果 iPhone 4S 未激活送礼包 完美越狱'
    end
    it 'has approve status' do
      product.approve_status.should == 'onsale'
    end
    it 'has auction point' do
      product.auction_point.should == 0
    end
    it 'has delist time' do
      product.delist_time.should == DateTime.new(2013,03,11, 12,25,28)
    end
    it 'has product type' do
      product.type.should == 'fixed'
    end

    it 'raises an exception when unknown property retrieved' do
      expect {
        product.unknown_property
      }.to raise_error NoMethodError
    end
  end
  subject { product }
  its(:user) { should be_a_kind_of Taobao::User }
end