# coding: utf-8
require 'spec_helper'

describe Taobao::ProductList do

  describe 'init with default options and category id' do
    pl = Taobao::ProductList.new(cid: 28)

    fixture = 'items'.json_fixture
    args = {
      method: 'taobao.items.get',
      fields: 'num_iid,title,nick,pic_url,cid,price,type,delist_time,post_fee,score,volume',
      cid: 28
    }

    it 'should return 40 items' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      pl.should have_exactly(40).items
    end
    it 'total count should be greater than zero' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      pl.total_count.should be > 0
    end
    it 'items could be iterated' do
      pl.each { |item| item.should be_a_kind_of(Taobao::Product) }
    end
  end

  describe 'init and use advanced options' do
    pl = Taobao::ProductList.new(cid: 28)
      .page(15)
      .per_page(10)
      .order_by_price

    fixture = 'items_page15'.json_fixture
    args = {
      method: 'taobao.items.get',
      fields: 'num_iid,title,nick,pic_url,cid,price,type,delist_time,post_fee,score,volume',
      cid: 28,
      page_no: 15,
      page_size: 10,
      order_by: 'price'
    }

    it 'should return 10 items' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      pl.should have_exactly(10).items
    end
  end

  describe 'unknown method' do
    it 'should raise exception' do
      pl = Taobao::ProductList.new(cid: 28)
      expect {
        pl.undefined_method
      }.to raise_error NoMethodError
    end
  end

  describe 'category without items' do
    it 'should return 0 items' do
      pl = Taobao::ProductList.new(cid: 283333)
      fixture = 'no_items'.json_fixture
      args = {
        method: 'taobao.items.get',
        fields: 'num_iid,title,nick,pic_url,cid,price,type,delist_time,post_fee,score,volume',
        cid: 283333
      }
      Taobao.stub(:api_request).with(args).and_return(fixture)
      pl.total_count.should == 0
      pl.should have_exactly(0).items
    end
  end

end