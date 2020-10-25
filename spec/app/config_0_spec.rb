RSpec.describe App::Config do
  it "has a version number" do
    expect(App::Config::VERSION).not_to be nil
  end
end
