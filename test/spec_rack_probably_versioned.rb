require File.dirname(__FILE__) + '/spec_helper'
require 'rack/mock'
require 'rack/contrib/probably_versioned'

context "Rack::ProbablyVersioned" do
  App = lambda { |env| [200, {'Content-Type' => 'text/plain'}, Rack::Request.new(env)] }

  specify "should do nothing when route not prefixed with 'v1/'" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, env['PATH_INFO']] }
    request = Rack::MockRequest.env_for("/resource.json")
    body = Rack::ProbablyVersioned.new(app).call(request).last
    body.should == "/resource.json"
  end

  specify "should remove 'v1/' route prefix" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, env['PATH_INFO']] }
    request = Rack::MockRequest.env_for("/v1/resource.json")
    body = Rack::ProbablyVersioned.new(app).call(request).last
    body.should == "/resource.json"
  end

end