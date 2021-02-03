require  "app/config/deeply"
using  Deeply

RSpec.describe "deeply" do
  it "deeply_dup" do
    org    =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    same   =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    out    =  org.deeply_dup
    org[:k1] = "V1"
    expect( out ).to eq( same )

    org    =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    same   =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    out    =  org.deeply_dup
    org[0][:k3] = "V3"
    expect( out ).to eq( same )
  end

  it "deeply_map" do
    down   =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    up     =  {:k1=>"V1", :ks=>[{:k2=>"V2"}, {:k3=>"V3"}], :k4=>"V4"}
    out    =  down.deeply_map do |val| val.upcase end
    expect( out ).to eq( up )

    down   =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    up     =  [{:k1=>["V1", "V2"]}, {:k1=>["W1","W2"]}]
    out    =  down.deeply_map do |val| val.upcase end
    expect( out ).to eq( up )

    down   =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    up     =  {:k1=>"V1", :ks=>[{:k2=>"V2"}, {:k3=>"V3"}], :k4=>"V4"}
    out    =  up.deeply_map do |val| val.downcase end
    expect( out ).to eq( down )

    down   =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    up     =  [{:k1=>["V1", "V2"]}, {:k1=>["W1","W2"]}]
    out    =  up.deeply_map do |val| val.downcase end
    expect( out ).to eq( down )
  end

  it "deeply_map!" do
    down   =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    up     =  {:k1=>"V1", :ks=>[{:k2=>"V2"}, {:k3=>"V3"}], :k4=>"V4"}
    out    =  down.deeply_dup
    out.deeply_map! do |val| val.upcase end
    expect( out ).to eq( up )

    down   =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    up     =  [{:k1=>["V1", "V2"]}, {:k1=>["W1","W2"]}]
    out    =  down.deeply_dup
    out.deeply_map! do |val| val.upcase end
    expect( out ).to eq( up )

    down   =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    up     =  {:k1=>"V1", :ks=>[{:k2=>"V2"}, {:k3=>"V3"}], :k4=>"V4"}
    out    =  up.deeply_dup
    out.deeply_map! do |val| val.downcase end
    expect( out ).to eq( down )

    down   =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    up     =  [{:k1=>["V1", "V2"]}, {:k1=>["W1","W2"]}]
    out    =  up.deeply_dup
    out.deeply_map! do |val| val.downcase end
    expect( out ).to eq( down )
  end

  it "deeply_merge" do
    org    =  {:k1=>"v1", :k2=>"v2", :k3=>{:k4=>"v4"}}
    src    =  {           :k2=>"w2", :k3=>{:k5=>"w5"}}
    ans    =  {:k1=>"v1", :k2=>"w2", :k3=>{:k4=>"v4",:k5=>"w5"}}
    out    =  org.deeply_merge( src )
    expect( out ).to eq( ans )
  end

  it "deeply_merge!" do
    org    =  {:k1=>"v1", :k2=>"v2", :k3=>{:k4=>"v4"}}
    src    =  {           :k2=>"w2", :k3=>{:k5=>"w5"}}
    ans    =  {:k1=>"v1", :k2=>"w2", :k3=>{:k4=>"v4",:k5=>"w5"}}
    out    =  org.deeply_dup
    out.deeply_merge!( src )
    expect( out ).to eq( ans )
  end

  it "deeply_stringify_keys" do
    sym    =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    str    =  {"k1"=>"v1", "ks"=>[{"k2"=>"v2"}, {"k3"=>"v3"}], "k4"=>"v4"}
    out    =  sym.deeply_stringify_keys
    expect( out ).to eq( str )

    sym    =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    str    =  [{"k1"=>["v1", "v2"]}, {"k1"=>["w1","w2"]}]
    out    =  sym.deeply_stringify_keys
    expect( out ).to eq( str )
  end

  it "deeply_stringify_keys!" do
    sym    =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    str    =  {"k1"=>"v1", "ks"=>[{"k2"=>"v2"}, {"k3"=>"v3"}], "k4"=>"v4"}
    out    =  sym.deeply_dup
    out.deeply_stringify_keys!
    expect( out ).to eq( str )

    sym    =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    str    =  [{"k1"=>["v1", "v2"]}, {"k1"=>["w1","w2"]}]
    out    =  sym.deeply_dup
    out.deeply_stringify_keys!
    expect( out ).to eq( str )
  end

  it "deeply_symbolize_keys" do
    sym    =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    str    =  {"k1"=>"v1", "ks"=>[{"k2"=>"v2"}, {"k3"=>"v3"}], "k4"=>"v4"}
    out    =  str.deeply_symbolize_keys
    expect( out ).to eq( sym )

    sym    =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    str    =  [{"k1"=>["v1", "v2"]}, {"k1"=>["w1","w2"]}]
    out    =  str.deeply_symbolize_keys
    expect( out ).to eq( sym )
  end

  it "deeply_symbolize_keys!" do
    sym    =  {:k1=>"v1", :ks=>[{:k2=>"v2"}, {:k3=>"v3"}], :k4=>"v4"}
    str    =  {"k1"=>"v1", "ks"=>[{"k2"=>"v2"}, {"k3"=>"v3"}], "k4"=>"v4"}
    out    =  str.deeply_dup
    out.deeply_symbolize_keys!
    expect( out ).to eq( sym )

    sym    =  [{:k1=>["v1", "v2"]}, {:k1=>["w1","w2"]}]
    str    =  [{"k1"=>["v1", "v2"]}, {"k1"=>["w1","w2"]}]
    out    =  str.deeply_dup
    out.deeply_symbolize_keys!
    expect( out ).to eq( sym )
  end
end

