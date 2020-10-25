
module App
  module Config

    class Error < StandardError; end

    DEFAULT_PATH  =  "$ROOT/config/defaults:$ROOT/config:$ROOT/var"

    module Base

      def new( *args, **opts )
        type  =  args.shift || :YAML
        case  type.to_sym
        when  :RUBY
          App::Config::RUBY.new( **opts )
        when  :YAML
          App::Config::YAML.new( **opts )
        when  :JSON
          App::Config::JSON.new( **opts )
        else
          raise  App::Config::Error, "unknown type: #{type}"
        end
      end

    end

  end
end

