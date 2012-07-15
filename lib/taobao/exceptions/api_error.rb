class Taobao::ApiError < StandardError
  def initialize(response)
    @msg = response[:error_response][:msg]
  end

  def to_s
    @msg
  end
end