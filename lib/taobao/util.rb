module Taobao::Util
  def to_object(hash)
    hash.each { |k, v| self.instance_variable_set "@#{k}", v }
  end
end