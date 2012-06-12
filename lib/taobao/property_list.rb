class Taobao::PropertyList

  include Enumerable

	def initialize(opts)
		@opts = opts
	end

	def each(&block)
		properties.each{|item| block.call(item)}
	end

	private
	def properties
		return @properties if @properties
		fields = [:pid, :name, :prop_values, :must, :multi, :is_color_prop,
      :is_key_prop, :is_enum_prop, :is_input_prop, :is_sale_prop,
      :is_item_prop].join ','
    params = {method: 'taobao.itemprops.get', fields: fields}
    result = Taobao.api_request(params.merge(@opts))
    @properties = []
    begin
      result[:itemprops_get_response][:item_props][:item_prop].each do |prop|
        @properties << Taobao::Property.new(prop)
      end
    rescue NoMethodError
    end
    @properties
	end
end