class Taobao::PropertyList < Taobao::AbstractList

	def each(&block)
		properties.each{ |item| block.call(item) }
	end

	private
	def properties
	  begin
      props = cached_responce[:itemprops_get_response][:item_props][:item_prop]
      props.map { |prop| Taobao::Property.new(prop) }
    rescue NoMethodError
      []
    end
	end
	
	def retrieve_response
	  fields = [:pid, :name, :prop_values, :must, :multi, :is_color_prop,
      :is_key_prop, :is_enum_prop, :is_input_prop, :is_sale_prop,
      :is_item_prop].join ','
    params = {method: 'taobao.itemprops.get', fields: fields}
    Taobao.api_request params.merge(@opts)
  end
end