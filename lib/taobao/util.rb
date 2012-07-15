module Taobao::Util
  def to_object(hash)
    hash.each do |k, v|
      self.instance_variable_set "@#{k}", v
    end
  end
end