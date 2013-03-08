class Nokogiri::XML::Node
  def to_symbolized_hash
    Hash[children.map { |c| [c.name.to_sym, c.value] }]
  end
  def value
    if !children.empty? && Nokogiri::XML::Text === children[0]
      text
    else
      to_symbolized_hash
    end
  end
end