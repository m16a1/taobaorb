class Taobao::Product

  include Taobao::Util

  BASIC_PROPERTIES = [:cid, :num_iid, :title, :nick, :price, :pic_url, :type,
     :score, :delist_time, :post_fee, :volume]

  OTHER_PROPERTIES = [:detail_url, :seller_cids, :props, :input_pids,
    :input_str, :desc, :num, :valid_thru, :list_time, :stuff_status,
    :location, :express_fee, :ems_fee, :has_discount, :freight_payer,
    :has_invoice, :has_warranty, :has_showcase, :modified, :increment,
    :approve_status, :postage_id, :product_id, :auction_point,
    :property_alias, :item_img, :prop_img, :sku, :video, :outer_id,
    :is_virtual, :sell_promise, :second_kill, :auto_fill, :props_name]

  attr_reader *BASIC_PROPERTIES
  alias :id :num_iid

  def initialize(product_properties)
    if Hash === product_properties
      to_object product_properties
      @all_properties_fetched = false
      convert_types
    else
      @num_iid = product_properties.to_s
      fetch_full_data
    end
  end

  def user
    Taobao::User.new @nick
  end

  def method_missing(method_name, *args, &block)
    if instance_variable_defined? "@#{method_name}"
      fetch_full_data unless @all_properties_fetched
      self.instance_variable_get "@#{method_name}"
    else
      super
    end
  end

  private

  def fetch_full_data
    fields = (BASIC_PROPERTIES + OTHER_PROPERTIES).join ','
    params = {method: 'taobao.item.get', fields: fields, num_iid: id}
    result = Taobao.api_request(params)
    to_object result[:item_get_response][:item]
    @all_properties_fetched = true
    convert_types
  end

  def convert_types
    @price = @price.to_f
    @cid = @cid.to_i
    @num_iid = @num_iid.to_i
    @auction_point = @auction_point.to_i
    @delist_time = DateTime.parse @delist_time
  end
end
