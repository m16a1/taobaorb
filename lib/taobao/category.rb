class Taobao::Category
	attr_reader :id, :name
	
	def initialize(category_id)
		@id = category_id.to_i
		fields = [:cid, :parent_cid, :name, :is_parent].join ','
		result = Taobao.api_request(method: 'taobao.itemcats.get', fields: fields, cid: @id)
		begin
			@name = result[:itemcats_get_response][:item_cats][:item_cat].first[:name]
		rescue NoMethodError
			raise Taobao::ApiError, 'Incorrect category ID'
		end
	end
	
	def subcategories
	end
	
end