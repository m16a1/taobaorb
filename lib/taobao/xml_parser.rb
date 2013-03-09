require 'nokogiri'

class Nokogiri::XML::Node
  def to_symbolized_hash
    children.each_with_object({}) do |child, hash|
      key = child.name.to_sym
      if hash.has_key? key
        if Array === hash[key]
          hash[key] << child.value
        else
          hash[key] = [hash[key], child.value]
        end
      else
        hash[key] = child.value
      end
    end
  end
  def value
    if !children.empty? && Nokogiri::XML::Text === children[0]
      text
    else
      to_symbolized_hash
    end
  end
end