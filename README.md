#taobaorb

Ruby wrapper for the Taobao API

##Examples
Setting public and private keys before any API calls:
```ruby
require 'taobaorb'
Taobao.public_key = your_public_key
Taobao.private_key = your_private_key
```

Retrieving category, category properties, category products:
```ruby
category = Taobao::Category.new(28)
puts category.name
puts category.subcategories
puts category.properties
puts category.products.size
puts category.products.total_count
```

Getting 10th page with 20 product per page and ordered by price:
```ruby
category.products.page(10).per_page(20).order_by_price.each do |product|
  puts product.title
  puts product.price
  puts product.pic_url

  puts product.desc
  puts product.has_discount
end
```

Searching for products:
```ruby
product_list = Taobao::search('iPhone').page(1).per_page(15).order_by_title
```
