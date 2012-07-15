class Taobao::Property
  attr_reader :multi, :must, :name, :pid, :values
  include Taobao::Util

  def initialize(response)
    @response = response
    to_object response
    @values = get_values
    raise Taobao::IncorrectProperty, 'Incorrect property data' if @name.nil?
  end

  private
  def get_values
    @response[:prop_values][:prop_value]
  rescue NoMethodError
    []
  end
end