RSpec.describe App::Config::RUBY do

  path  =  "$ROOT/config/defaults/:$ROOT/config:$ROOT/var"

  it "new" do
    expect( App::Config.new(:RUBY ).class ).to  eq( App::Config::RUBY )
    expect( App::Config.new("RUBY").class ).to  eq( App::Config::RUBY )
    expect( App::Config.new(:RUBY,  path: path ).class ).to  eq( App::Config::RUBY )
    expect( App::Config.new("RUBY", path: path ).class ).to  eq( App::Config::RUBY )
    expect( App::Config::RUBY.new.class ).to  eq( App::Config::RUBY )
    expect( App::Config::RUBY.new(path: path).class ).to  eq( App::Config::RUBY )
    expect( App::Config::RUBY.new(root: Dir.pwd).class ).to  eq( App::Config::RUBY )
  end

  it "reload" do
    value0  =  ::Time.now.iso8601(6)
    config  =  App::Config::RUBY.new
    value1  =  config["test"]["value"]
    config["test"]["value"]  =  value0
    config.reload
    value2  =  config["test"]["value"]
    expect( value2 ).to  eq( value1 )
  end

  it "save" do
    value0  =  ::Time.now.iso8601(6)
    config  =  App::Config::RUBY.new
    value1  =  config["test"]["value"]
    config["test"]["value"]  =  value0
    config.save("test")

    pathname  =  config.savepathname("test")
    text  =  ::File.open(pathname).read
    hash  =  eval( text )

    value2  =  hash["test"]["value"]
    expect( value2 ).not_to  eq( value1 )
    expect( value2 ).to  eq( value0 )
  end

  it "load" do
    value0  =  ::Time.now.iso8601(6)
    config  =  App::Config::RUBY.new
    value1  =  config["test"]["value"]
    config["test"]["value"]  =  value0

    pathname  =  config.savepathname("test")
    hash  =  {"test"=>config["test"]}
    text  =  hash.inspect
    ::File.open(pathname, "w") do |f|
      f.puts( text )
    end

    config.load("test")
    value2  =  config["test"]["value"]
    expect( value2 ).not_to  eq( value1 )
    expect( value2 ).to  eq( value0 )

    config.reset("test")
  end

  it "reset" do
    value0  =  ::Time.now.iso8601(6)
    config  =  App::Config::RUBY.new
    value1  =  config["test"]["value"]
    config["test"]["value"]  =  value0
    config.save("test")

    pathname  =  config.savepathname("test")
    text  =  ::File.open(pathname).read
    hash  =  eval( text )

    value2  =  hash["test"]["value"]
    expect( value2 ).not_to  eq( value1 )
    expect( value2 ).to  eq( value0 )

    config.reset("test")
    value3  =  config["test"]["value"]
    expect( value3 ).not_to  eq( value0 )
    expect( value3 ).to  eq( value1 )
  end

end

