#taobaorb

Ruby wrapper for the Taobao API

###Examples
```ruby
Taobao.public_key = your_public_key
Taobao.private_key = your_private_key

category = Taobao::Category.new(28)
puts category.name
puts category.subcategories
puts category.properties
puts category.products.size
puts category.products.total_count

category.products.page(10).per_page(20).order_by_price.each do |product|
  puts product.title
  puts product.price
  puts product.pic_url

  puts product.desc
  puts product.has_discount
end
```
