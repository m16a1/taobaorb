# coding: utf-8
require 'spec_helper'

describe Taobao do
  
  describe 'search method returns product list' do
    search = Taobao::search('iPhone')
    
    fixture = 'search.json'.json_fixture
    args = {
      method: 'taobao.items.get',
      fields: 'num_iid,title,nick,pic_url,cid,price,type,delist_time,post_fee,score,volume',
      q: 'iPhone'
    }

    it 'should return 40 items' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      search.size.should == 40
    end
    it 'total count should be greater than zero' do
      Taobao.stub(:api_request).with(args).and_return(fixture)
      search.total_count.should be > 0
    end
  end
end