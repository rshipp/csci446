#!/usr/bin/env ruby

require 'rack'
require 'csv'
require 'erb'
require 'sqlite3'

class BooksApp
  attr_accessor :options
  include ERB::Util

  def initialize
    # Set up variables that will be needed later.
    @db = SQLite3::Database.new "books.sqlite3.db"
    @options = ['title', 'author', 'language', 'year']
  end

  def call env
    # Create request and response objects.
    request = Rack::Request.new(env)
    response = Rack::Response.new

    # Include the header.
    File.open("header.html", "r") { |head| response.write(head.read) }
    
    case env["PATH_INFO"]
      when /.*?\.css/
        # Serve up a css file. Remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/form.*/
        # Serve up the form.
        render_form request, response
      when /\/list.*/
        # Serve up a list response.
        render_list request, response
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
    end

    # Include the footer.
    File.open("footer.html", "r") { |foot| response.write(foot.read) }
    response.finish
  end


  # /form
  def render_form req, response
    template = File.open('form.html.erb', 'r').read
    response.write(ERB.new(template).result binding)
  end

  # /list
  def render_list req, response
    sort = req.GET["sort"]
    if @options.include? sort
      template = File.open('list.html.erb', 'r').read
      books = []
      table = @db.execute("select * from books")
      (table.sort_by { |e| e[(@options.index sort)+1] }).each do |book|
        col = []
        book.each do |field|
          col.push field
        end
        books.push col
      end
      response.write(ERB.new(template).result binding)
    else
      response.write "\t\tParameter sort=#{sort} is not allowed.\n"
    end
  end
end


Signal.trap('INT') {
  Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run BooksApp.new, :Port => 8080
