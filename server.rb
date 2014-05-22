require 'sinatra'
require 'csv'
require 'shotgun'

def sort_file(csv)
  @articles = []

  CSV.foreach('articles.csv') do |row|
    article = {
      article_title: row[0],
      article_link: row[1],
      article_description: row[2]
    }
  @articles << article
  end
end

get '/' do
  @articles = CSV.readlines('articles.csv')
  sort_file('articles.csv')
  erb :index
end

post '/articles' do
  @title = params[:article_title]

  @link = params[:article_link]

  @description = params[:article_description]

  CSV.open('articles.csv', 'a') do |csv|
    csv << [@title, @link, @description]
  end

  redirect '/'
end


set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
