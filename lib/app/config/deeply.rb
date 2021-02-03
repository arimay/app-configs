# frozen_string_literal: true

module Deeply

  ## deeply_symbolize_keys

  refine Hash do
    def deeply_symbolize_keys!
      temp  =  self.deeply_symbolize_keys
      self.clear
      self.merge!( temp )
    end

    def deeply_symbolize_keys
      self.each_with_object({}) do |(key, obj), hash|
        k  =  key.to_s.to_sym
        case  obj
        when  Array, Hash
          hash[k]  =  obj.deeply_symbolize_keys
        else
          hash[k]  =  obj
        end
      end
    end
  end

  refine Array do
    def deeply_symbolize_keys!
      temp  =  self.deeply_symbolize_keys
      self.clear
      self.push( *temp )
    end

    def deeply_symbolize_keys
      self.map do |obj|
        case  obj
        when  Array, Hash
          obj.deeply_symbolize_keys
        else
          obj.dup
        end
      end
    end
  end


  ## deeply_stringify_keys

  refine Hash do
    def deeply_stringify_keys!
      temp  =  self.deeply_stringify_keys
      self.clear
      self.merge!( temp )
    end

    def deeply_stringify_keys
      self.each_with_object({}) do |(key, obj), hash|
        k  =  key.to_s
        case  obj
        when  Array, Hash
          hash[k]  =  obj.deeply_stringify_keys
        else
          hash[k]  =  obj
        end
      end
    end
  end

  refine Array do
    def deeply_stringify_keys!
      temp  =  self.deeply_stringify_keys
      self.clear
      self.push( *temp )
    end

    def deeply_stringify_keys
      self.map do |obj|
        case  obj
        when  Array, Hash
          obj.deeply_stringify_keys
        else
          obj.dup
        end
      end
    end
  end


  ## deeply_merge

  refine Hash do
    def deeply_merge( hash )
      raise  ArgumentError( "type invalid. : %s" % hash )    unless  hash.is_a? Hash

      temp  =  self.deeply_dup
      temp.deeply_merge!( hash )
      temp
    end

    def deeply_merge!( hash )
      raise  ArgumentError( "type invalid. : %s" % hash )    unless  hash.is_a? Hash

      hash.each do |key, obj|
        case  obj
        when  NilClass
          self[key]  =  nil
        when  Hash
          self[key]  =  {}    if self[key].nil?
          self[key].deeply_merge!(obj)
        else
          self[key]  =  obj.dup
        end
      end
    end
  end


  ## deeply_map

  refine Hash do
    def deeply_map( &block )
      temp  =  self.deeply_dup
      temp.deeply_map!( &block )
      temp
    end

    def deeply_map!( &block )
      self.each do |key, obj|
        case  obj
        when  NilClass
          self[key]  =  nil
        when  Array, Hash
          self[key].deeply_map!( &block )
        else
          self[key]  =  block.call( obj )
        end
      end
    end
  end

  refine Array do
    def deeply_map( &block )
      temp  =  self.deeply_dup
      temp.deeply_map!( &block )
      temp
    end

    def deeply_map!( &block )
      self.map! do |obj|
        case  obj
        when  NilClass
          nil
        when  Array, Hash
          obj.deeply_map!( &block )
        else
          block.call( obj )
        end
      end
    end
  end


  ## deeply_dup

  refine Hash do
    def deeply_dup
      self.each_with_object({}) do |(key, obj), hash|
        case  obj
        when  NilClass
          hash[key]  =  nil
        when  Array, Hash
          hash[key]  =  obj.deeply_dup
        else
          hash[key]  =  obj.dup
        end
      end
    end
  end

  refine Array do
    def deeply_dup
      self.map do |obj|
        case  obj
        when  NilClass
          nil
        when  Array, Hash
          obj.deeply_dup
        else
          obj.dup
        end
      end
    end
  end

end

