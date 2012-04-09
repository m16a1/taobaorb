require 'digest/md5'
require 'uri'
require 'net/http'
require 'json'

module Taobao
	
	API_VERSION    = '2.0'
	PRODUCTION_URL = 'http://gw.api.taobao.com/router/rest'
	
	class << self
		attr_accessor :public_key
		attr_writer   :private_key
	end
	
	def self.api_request(options)
		options[:app_key]    = @public_key
		options[:format]     = :json
		options[:v]          = API_VERSION
		options[:timestamp]  = Date.new.strftime('%Y-%m-%d %H:%M:%S')
		options[:sign_method] = :md5
		options[:sign] = self.create_signature(options)
		
		uri = URI(PRODUCTION_URL)
		response = Net::HTTP.post_form(uri, options)
		JSON.parse response.body, {symbolize_names: true}
	end
	
	def self.create_signature(options)
		values_str = options.sort.inject('') do |str, item|
			str + item.first.to_s + item.last.to_s
		end
		Digest::MD5.hexdigest(@private_key + values_str + @private_key).upcase
	end
	
end
