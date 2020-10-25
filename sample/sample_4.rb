require  "app/config"

type  =  ARGV.shift || :YAML

# initialize object, load and merge all sections.
config  =  App::Config.new(type)

# remove and reload section
config.reset("status")

