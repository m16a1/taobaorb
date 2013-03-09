# coding: utf-8
require 'spec_helper'

describe Taobao do

  describe 'search method returns product list' do
    let(:search) { Taobao::search('iPhone') }
    before do
      args = {
        method: 'taobao.items.get',
        fields: 'num_iid,title,nick,pic_url,cid,price,type,delist_time,post_fee,score,volume',
        q: 'iPhone'
      }
      Taobao.stub(:api_request).with(args).and_return 'search'.xml_fixture
    end

    it 'should return 40 items' do
      search.should have(40).results
    end
    it 'total count should be greater than zero' do
      search.total_count.should be > 0
    end
  end
end