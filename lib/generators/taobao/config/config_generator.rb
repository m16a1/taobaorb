require 'rails/generators/named_base'

module Taobao
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Creates a taobaorb configuration file at config/taobaorb.yml"
      source_root File.dirname(__FILE__)
      def copy_config
        copy_file 'taobaorb.yml', 'config/taobaorb.yml'
      end
    end
  end
end