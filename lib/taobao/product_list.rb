class Taobao::ProductList
  
  include Enumerable
  
  def initialize(opts)
    @opts = opts
  end
  
  def size
    products.size
  end
  
  def total_count
    products unless @total_count
    @total_count
  end
  
  private
  def products
    return @products if @products
    fields = [:num_iid, :title, :nick, :pic_url, :cid, :price, :type,
      :delist_time, :post_fee, :score, :volume].join ','
    params = {method: 'taobao.items.get', fields: fields}
    result = Taobao.api_request(params.merge(@opts))
    begin
      @total_count = result[:items_get_response][:total_results]
      @products = result[:items_get_response][:items][:item]
    rescue NoMethodError
      @total_count = 0
      @products = []
    end
  end
  
end