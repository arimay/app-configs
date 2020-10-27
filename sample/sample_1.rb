require  "app/config"

path  =  "$ROOT/config/defaults/:$ROOT/config:$ROOT/var"

# initialize variation

pp  App::Config.new
pp  App::Config.new( root: Dir.pwd )
pp  App::Config.new( path: path )

pp  App::Config.new( :YAML )
pp  App::Config.new( "YAML" )
pp  App::Config.new( :YAML, path: path )
pp  App::Config.new( "YAML", path: path )
pp  App::Config::YAML.new
pp  App::Config::YAML.new( path: path )

pp  App::Config.new( :JSON )
pp  App::Config.new( "JSON" )
pp  App::Config.new( :JSON, path: path )
pp  App::Config.new( "JSON", path: path )
pp  App::Config::JSON.new
pp  App::Config::JSON.new( path: path )

