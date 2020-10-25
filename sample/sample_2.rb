require  "app/config"

path  =  "$ROOT/config/defaults/:$ROOT/config:$ROOT/var"

type  =  ARGV.shift || :YAML
config  =  App::Config.new(type)

pp config.class
pp config.keys
pp config

config.reload
config.reload( path: path )
config.load("section")

value  =  config["section"]["seqn"].to_i
p ["seqn", value]
config["section"]["seqn"]  =  value + 1
config.save("section")

