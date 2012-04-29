class Taobao::Category
  attr_reader :id
  
  def initialize(category_id)
    @id = category_id.to_i
  end
  
  def name
    return @name if @name
    @name = category_request(cids: @id).first[:name]
  end
  
  def subcategories
    return @subcategories if @subcategories
    @subcategories = category_request(parent_cid: @id)
  end
  
  def properties
    return @properties if @properties
    fields = [:pid, :name, :must, :multi, :prop_values].join ','
    params = {method: 'taobao.itemprops.get', fields: fields, cid: @id}
    result = Taobao.api_request params
    begin
      result[:itemprops_get_response][:item_props][:item_prop]
    rescue NoMethodError
      @properties = []
    end
  end
  
  def products
    Taobao::ProductList.new(cid: @id)
  end
  
  private
  def category_request(optional_params)
    fields = [:cid, :parent_cid, :name, :is_parent].join ','
    params = {method: 'taobao.itemcats.get', fields: fields}
    result = Taobao.api_request(params.merge(optional_params))
    begin
      result[:itemcats_get_response][:item_cats][:item_cat]
    rescue NoMethodError
      raise Taobao::ApiError, 'Incorrect category ID'
    end
  end
  
end