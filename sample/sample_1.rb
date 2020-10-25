require  "app/config"

path  =  "$ROOT/config/defaults/:$ROOT/config:$ROOT/var"

# initialize variation

pp config  =  App::Config.new
pp config  =  App::Config.new( root: Dir.pwd )
pp config  =  App::Config.new( path: path )

pp config  =  App::Config.new( :YAML )
pp config  =  App::Config.new( "YAML" )
pp config  =  App::Config.new( :YAML, path: path )
pp config  =  App::Config.new( "YAML", path: path )
pp config  =  App::Config::YAML.new
pp config  =  App::Config::YAML.new( path: path )

pp config  =  App::Config.new( :JSON )
pp config  =  App::Config.new( "JSON" )
pp config  =  App::Config.new( :JSON, path: path )
pp config  =  App::Config.new( "JSON", path: path )
pp config  =  App::Config::JSON.new
pp config  =  App::Config::JSON.new( path: path )

