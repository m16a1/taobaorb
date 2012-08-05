require 'rails/railtie'

module Taobao
  class Railtie < ::Rails::Railtie
    initializer 'set API keys' do
      begin
        config = YAML.load_file(Rails.root.join('config', 'taobaorb.yml'))[Rails.env]
        Taobao.public_key = config['public_key']
        Taobao.private_key = config['private_key']
        p Taobao.public_key
      rescue Errno::ENOENT
        puts 'Taobao config not found.'
        puts 'To generate one run: rails g taobao:config'
      end
    end
  end
end
