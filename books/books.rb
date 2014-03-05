#!/usr/bin/ruby

require 'rack'

class BooksApp
  def initialize()
    # Set up variables that will be needed later.
    
  end

  def call(env)
    # Create request and response objects.
    request = Rack::Request.new(env)
    response = Rack::Response.new

    # Include the header.
    File.open("header.html", "r") { |head| response.write(head.read) }
    
    case env["PATH_INFO"]
      when /.*?\.css/
        # Serve up a css file.
        # Remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/form.*/
        # Serve up the form.
        render_form(request, response)
      when /\/list.*/
        # Serve up a list response.
        render_list(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end

    # Include the footer.
    File.open("footer.html", "r") { |foot| response.write(foot.read) }
    response.finish
  end

  # /form
  def render_form req, response
    response.write "Form"
  end

  # /list
  def render_list req, response
    sort = req.GET["sort"]
    response.write "List"
  end
end


Signal.trap('INT') {
  Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run BooksApp.new, :Port => 8080
