require File.dirname(__FILE__) + '/spec_helper'
require 'rack/contrib'

context "Rack::Contrib" do
  specify "should expose release" do
    Rack::Contrib.should.respond_to :release
  end
end
