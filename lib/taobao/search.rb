module Taobao
  # Search products by name
  # @param query [String]
  # @return [Taobao::ProductList] list of found products
  def self.search(query)
    ProductList.new(q: query)
  end
end