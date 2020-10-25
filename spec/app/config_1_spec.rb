RSpec.describe App::Config do

  path  =  "$ROOT/config/defaults/:$ROOT/config:$ROOT/var"

  it "new" do
    expect( App::Config.new.class ).to  eq( App::Config::YAML )
    expect( App::Config.new(path: path).class ).to  eq( App::Config::YAML )
    expect( App::Config.new(root: Dir.pwd).class ).to  eq( App::Config::YAML )
  end

end

