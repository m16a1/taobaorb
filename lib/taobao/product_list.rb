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
    m = /^order_by_(?<field>.+)$/.match(method_name)
    if m
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
    return @products if @products
    fields = [:num_iid, :title, :nick, :pic_url, :cid, :price, :type,
      :delist_time, :post_fee, :score, :volume].join ','
    params = {method: 'taobao.items.get', fields: fields}
    result = Taobao.api_request(params.merge(@opts))
    begin
      @total_count = result[:items_get_response][:total_results]
      @products = []
      result[:items_get_response][:items][:item].each do |product|
        @products << Taobao::Product.new(product)
      end
    rescue NoMethodError
      @total_count = 0
      @products = []
    end
  end
  
end