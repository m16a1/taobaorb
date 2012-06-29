class Taobao::ProductList
  
  include Enumerable
  
  def initialize(opts)
    @opts = opts
  end
  
  def size
    products.size
  end
  
  def total_count
    memoize_api_result
    @total_count
  end
  
  def page(num)
    @products = nil
    @opts[:page_no] = num
    self
  end
  
  def per_page(num)
    @products = nil
    @opts[:page_size] = num
    self
  end
  
  def order_by(field)
    @products = nil
    @opts[:order_by] = field
    self
  end
  
  def method_missing(method_name, *args, &block)
    if (m = /^order_by_(?<field>.+)$/.match method_name)
      order_by m[:field]
    else
      super
    end
  end
  
  def each(&block)
    products.each{|item| block.call(item)}
  end
  
  private
  def products
    memoize_api_result
    @products
  end
  
  def memoize_api_result
    return if @products
    response = items_get_request
    @total_count = retrieve_total_count(response)
    @products = retrieve_products(response)
  end
  
  def retrieve_total_count(response)
    response[:items_get_response][:total_results].to_i
  end
  
  def retrieve_products(response)
    begin
      products = response[:items_get_response][:items][:item]
      get_products_as_objects(products)
    rescue NoMethodError
      []
    end
  end
  
  def get_products_as_objects(products)
    products.map do |product|
      Taobao::Product.new(product)
    end
  end
  
  def items_get_request
    fields = [:num_iid, :title, :nick, :pic_url, :cid, :price, :type,
      :delist_time, :post_fee, :score, :volume].join ','
    params = {method: 'taobao.items.get', fields: fields}
    Taobao.api_request(params.merge(@opts))
  end
end