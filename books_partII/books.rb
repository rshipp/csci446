#!/usr/bin/env ruby

require 'data_mapper'
require 'sinatra'
require_relative 'book'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/books.sqlite3.db")

books = []
Book.all.each { |book| books.push [book.id, book.title, book.author, book.language, book.published] }
puts books
options = ['rank', 'title', 'author', 'language', 'year']

get '/form' do
  erb :base, locals: {page: 'form', options: options, books: nil, sort: nil}
end

get '/list' do
  sort = request.GET["sort"]
  if options.include? sort
    table = []
    (books.sort_by { |e| e[options.index sort] }).each do |book|
      col = []
      book.each do |field|
        col.push field
      end
      table.push col
    end
    return erb :base, locals: {page: 'list', options: options, books: table, sort: sort}
  else
    return "Parameter sort=#{sort} is not allowed.\n"
  end
end
