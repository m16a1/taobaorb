class Taobao::AbstractList
  include Enumerable

  def initialize(opts)
    @opts = opts
  end

  private
  def cached_responce
    @response ||= retrieve_response
  end

  def clear_response
    @response = nil
  end
end