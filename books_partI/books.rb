#!/usr/bin/env ruby

require 'rack'
require 'csv'
require 'ERB'
require 'sqlite3'

class BooksApp
  def initialize
    # Set up variables that will be needed later.
    @books = []
    f = File.open("books.csv", "r")
    f.each do |line|
      l = []
      (CSV.parse_line line).each do |row|
        l.push row.strip
      end
      @books.push l
    end
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
    page = []

    page.push "<form method='GET' action='/list'>"
    page.push "\t<select name='sort'>"
    @options.each do |option|
      page.push "\t\t<option>#{option}</option>"
    end
    page.push "\t</select>"
    page.push "\t<button type='submit'>Display List</button>"
    page.push "</form>"

    page.each do |line|
      response.write "\t\t" + line + "\n"
    end
  end

  # /list
  def render_list req, response
    sort = req.GET["sort"]
    page = []

    if @options.include? sort
      page.push "<h2>Sorted by #{sort}</h2>"
      page.push "<table cellborder=1>"
      page.push "\t<tr>"
      page.push "\t\t<th>Rank</th>"
      page.push "\t\t<th>Title</th>"
      page.push "\t\t<th>Author</th>"
      page.push "\t\t<th>Language</th>"
      page.push "\t\t<th>Year</th>"
      page.push "\t\t<th>Copies</th>"
      page.push "\t</tr>"

      (@books.sort_by { |e| e[@options.index sort] }).each do |book|
        page.push "\t<tr>"
        page.push "\t\t<td>#{(@books.index book) + 1}</td>"
        book.each do |field|
          page.push "\t\t<td>#{field}</td>"
        end
        page.push "\t</tr>"
      end

      page.push "</table>"
    else
      page.push "Parameter sort=#{sort} is not allowed."
    end

    page.each do |line|
      response.write "\t\t" + line + "\n"
    end
  end
end


Signal.trap('INT') {
  Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run BooksApp.new, :Port => 8080
