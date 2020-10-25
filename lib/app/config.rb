require "app/config/version"
require "app/config/base"
require "app/config/deeply"

module App
  module Config
    class Error < StandardError; end

    class  <<  self
      include App::Config::Base
    end

    autoload  :RUBY, "app/config/ruby"
    autoload  :YAML, "app/config/yaml"
    autoload  :JSON, "app/config/json"
  end
end

