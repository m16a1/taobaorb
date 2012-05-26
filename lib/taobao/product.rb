class Taobao::Product
  attr_reader :cid, :num_iid, :title, :nick, :price, :pic_url, :type, :score,
              :delist_time, :post_fee, :volume
  alias :id :num_iid 
  
  def initialize(product_properties)
    product_properties.each do |k, v|
      self.instance_variable_set("@#{k}", v)
    end
  end
end