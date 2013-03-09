class Taobao::Property
  attr_reader :multi, :must, :name, :pid, :values
  include Taobao::Util

  # @param response [Hash]
  def initialize(response)
    @response = response
    to_object response
    @values = get_values
    raise Taobao::IncorrectProperty, 'Incorrect property data' unless @name
    convert_data_types
  end

  private
  def get_values
    @response[:prop_values][:prop_value]
  rescue NoMethodError
    []
  end

  def convert_data_types
    @must = @must == 'true'
    @multi = @multi == 'true'
    @pid = @pid.to_i
    @values.map! do |v|
      v[:vid] = v[:vid].to_i
      v[:is_parent] = v[:is_parent] == 'true'
      v
    end
  end
end