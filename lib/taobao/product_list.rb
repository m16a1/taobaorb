class Taobao::ProductList < Taobao::AbstractList

  def size
    products.size
  end

  def page(num)
    clear_response
    @opts[:page_no] = num
    self
  end

  def per_page(num)
    clear_response
    @opts[:page_size] = num
    self
  end

  def order_by(field)
    clear_response
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

  def total_count
    cached_responce[:items_get_response][:total_results].to_i
  end

  private
  def products
    products = cached_responce[:items_get_response][:items][:item]
    get_products_as_objects(products)
  rescue NoMethodError
    []
  end

  def get_products_as_objects(products)
    products.map do |product|
      Taobao::Product.new(product)
    end
  end

  def retrieve_response
    fields = [:num_iid, :title, :nick, :pic_url, :cid, :price, :type,
      :delist_time, :post_fee, :score, :volume].join ','
    params = {method: 'taobao.items.get', fields: fields}
    Taobao.api_request(params.merge(@opts))
  end
end