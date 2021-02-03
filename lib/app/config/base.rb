
module App
  module Config

    module Base
      def initialize
        self.default_proc  =  proc do |hash, key|
          hash[key]  =  {}
        end
      end
    end

  end
end

