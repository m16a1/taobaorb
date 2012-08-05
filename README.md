#taobaorb

Ruby wrapper for the Taobao API

## Getting started
At the command prompt, install taobaorb:
```bash
gem install taobaorb
```

## Using with Rails
Since v0.9.1 taobaorb works with Rails 3.1+.
You can add it to your Gemfile with:
```ruby
gem 'taobaorb'
```
Run bundle command to install, and run generator:
```bash
bundle install
rails g taobao:config
```
Then specify your public and private API keys in config/taobaorb.yml

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

Retrieving user info by his/her nickname:
```ruby
user = Taobao::User.new(username)

# All available methods:
# buyer_credit
user.good_purchases_count
user.buyer_level
user.buyer_score
user.total_purchases_count

# seller_credit
user.good_sales_count
user.seller_level
user.seller_score
user.total_sales_count

user.registration_date
user.last_visit

user.city
user.state

user.sex              # :male, :female or :unknown
user.type

user.uid
user.id
```

## License
Copyright (C) 2012 m16a1

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.