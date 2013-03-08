require 'spec_helper'

describe Nokogiri::XML::Node do
  context '#value' do
    let(:xml) do
      <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <top><tag>Hi</tag></top>
      XML
    end
    let(:doc) { Nokogiri::XML(xml) }
    let(:top) { doc.root.children[0] }
    it 'equals contents of text node' do
      top.value.should == 'Hi'
    end
  end
  context '#to_symbolized_hash' do
    let(:xml) do
      '<?xml version="1.0" encoding="utf-8" ?>     <top><tag>Hi</tag><array><item>value</item></array></top>'
    end
    let(:doc) { Nokogiri::XML(xml) }
    it 'equals contents of text node' do
      doc.to_symbolized_hash.should == {top: {tag: 'Hi', array: {item: 'value'}}}
    end
  end
end