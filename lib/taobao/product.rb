class Taobao::Product
  BASIC_PROPERTIES = [:cid, :num_iid, :title, :nick, :price, :pic_url, :type,
     :score, :delist_time, :post_fee, :volume]

  OTHER_PROPERTIES = [:detail_url, :seller_cids, :props, :input_pids,
    :input_str, :desc, :num, :valid_thru, :list_time, :stuff_status,
    :location, :express_fee, :ems_fee, :has_discount, :freight_payer,
    :has_invoice, :has_warranty, :has_showcase, :modified, :increment,
    :approve_status, :postage_id, :product_id, :auction_point,
    :property_alias, :item_img, :prop_img, :sku, :video, :outer_id,
    :is_virtual]
  
  attr_reader *BASIC_PROPERTIES
  alias :id :num_iid
  
  def initialize(product_properties)
    @all_properties_fetched = false
    
    if Hash === product_properties
      hash_to_object(product_properties)
    else
      @id = product_properties.to_s
      fetch_full_data
    end
  end
  
  def method_missing(method_name, *args, &block)
      unless OTHER_PROPERTIES.include? method_name
        super
      else
        fetch_full_data unless @all_properties_fetched
        self.instance_variable_get "@#{method_name}"
      end
  end
  
  private
  def hash_to_object(hash)
    hash.each do |k, v|
      self.instance_variable_set "@#{k}", v
    end
  end
  
  def fetch_full_data
    fields = (BASIC_PROPERTIES + OTHER_PROPERTIES).join ','
    params = {method: 'taobao.item.get', fields: fields, num_iid: @id}
    result = Taobao.api_request(params)
    hash_to_object(result[:item_get_response][:item])
    @all_properties_fetched = true
  end
end