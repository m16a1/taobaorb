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

  # Performs API calls to Taobao
  #
  # @param options [Hash]
  # @return [Hash] API request result
  def self.api_request(options)
    uri = URI(PRODUCTION_URL)
    response = Net::HTTP.post_form uri, self.append_required_options(options)
    parse_to_hash response
  end

  private
  def self.create_signature(options)
    values_str = options.sort.inject('') do |str, item|
      str + item.first.to_s + item.last.to_s
    end
    str = @private_key.to_s + values_str + @private_key.to_s
    Digest::MD5.hexdigest(str).upcase
  end

  def self.append_required_options(options)
    options.merge!({
      app_key:     @public_key,
      format:      :json,
      v:           API_VERSION,
      timestamp:   Time.now.strftime('%Y-%m-%d %H:%M:%S'),
      sign_method: :md5
    })
    options[:sign] = self.create_signature(options)
    options
  end

  def self.parse_to_hash(response)
    result = JSON.parse response.body, {symbolize_names: true}
    raise Taobao::ApiError.new(result) if result.key? :error_response
    result
  end
end
