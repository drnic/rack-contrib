require File.dirname(__FILE__) + '/spec_helper'
require 'rack/mock'
require 'rack/contrib/etag'

context "Rack::ETag" do
  specify "sets ETag if none is set" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, "Hello, World!"] }
    response = Rack::ETag.new(app).call({})
    response[1]['ETag'].should.equal "\"65a8e27d8879283831b664bd8b7f0ad4\""
  end

  specify "does not change ETag if it is already set" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain', 'ETag' => '"abc"'}, "Hello, World!"] }
    response = Rack::ETag.new(app).call({})
    response[1]['ETag'].should.equal "\"abc\""
  end

  specify "does not set ETag if steaming body" do
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ["Hello", "World"]] }
    response = Rack::ETag.new(app).call({})
    response[1]['ETag'].should.equal nil
  end
end
