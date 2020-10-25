
## deeply_symbolize_keys

class Hash
  def deeply_symbolize_keys!
    hash  =  self.deeply_symbolize_keys
    self.clear
    self.merge( hash )
  end

  def deeply_symbolize_keys
    self.each_with_object({}) do |(key, obj), hash|
      k  =  key.to_s.to_sym
      case  obj
      when  Hash
        hash[k]  =  obj.deeply_symbolize_keys
      else
        hash[k]  =  obj
      end
    end
  end
end


## deeply_stringify_keys

class Hash
  def deeply_stringify_keys!
    hash  =  self.deeply_stringify_keys
    self.clear
    self.merge( hash )
  end

  def deeply_stringify_keys
    self.each_with_object({}) do |(key, obj), hash|
      k  =  key.to_s
      case  obj
      when  Hash
        hash[k]  =  obj.deeply_stringify_keys
      else
        hash[k]  =  obj
      end
    end
  end
end


## deeply_merge

class Hash
  def deeply_merge( hash )
    self.dup.deeply_merge!( hash )
  end

  def deeply_merge!( hash )
    raise  ArgumentError("Type Invalid.")    unless Hash === hash

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

class Hash
  def deeply_map( &block )
    self.dup.deeply_map!( &block )
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

class Array
  def deeply_map( &block )
    self.dup.deeply_map!( &block )
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

class Hash
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

class Array
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

