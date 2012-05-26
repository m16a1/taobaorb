module Taobao
  def self.search(query)
    ProductList.new(q: query)
  end
end