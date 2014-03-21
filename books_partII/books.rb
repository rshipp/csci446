#!/usr/bin/env ruby

require 'data_mapper'
require 'sinatra'
require_relative 'book'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/books.sqlite3.db")

books = []
Book.all.each { |book| books.push [book.id, book.title, book.author, book.language, book.published, book.sold] }
options = ['rank', 'title', 'author', 'language', 'year']

get '/form' do
  erb :form, locals: {options: options, books: nil, sort: nil}
end

post '/list' do
  sort = request.POST["sort"]
  if options.include? sort
    books = books.sort_by { |e| e[options.index sort] }
    return erb :list, locals: {options: options, books: books, sort: sort}
  else
    return "Parameter sort=#{sort} is not allowed.\n"
  end
end
