require  "app/config"
require  "time"

type  =  ARGV.shift || :YAML

# initialize object, load and merge all sections.
config  =  App::Config.new(type)

# save section
config["status"]["lastdate"]  =  Time.now.iso8601(3)
config.save("status")

# show section
pp config["status"]

# debug print
Dir.glob("var/*.#{type.to_s.downcase}") do |pathname|
  p  pathname
  puts  open(pathname).read
end

