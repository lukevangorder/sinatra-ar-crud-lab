
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id/edit' do
    @id = params[:id]
    @articles = Article.all
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.title = params[:title]
    article.content = params[:content]
    article.save
    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.find(params[:id]).delete
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

end
