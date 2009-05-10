# Temporary middleware for your APIs to immediately support a /v1/some/path.json prefix to
# all route calls. 
#
# When you decide to freeze a current API and provide a /v2/ route then
# you will cease using this middleware and implement /v1/ and /v2/ routing as appropriate
# to your app.
#
# This middleware provides a placeholder until then so users can be told to use /v1/some/path routes
# immediately.
#
# Example:
#   /resource.json -> /resource.json
#   /v1/resource.json -> /resource.json
#
# MIT-License - Dr Nic Williams, http://drnicwilliams.com
#
module Rack
  class ProbablyVersioned
    def initialize(app)
      @app = app
    end
    
    def call(env)
      req = Rack::Request.new(env)
      if req.path_info =~ /\/?v1(.+)/
        req.path_info = $1
      end
      @app.call(env)
    end
  end
end