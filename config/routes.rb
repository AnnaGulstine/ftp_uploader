Rails.application.routes.draw do
  get '/' => 'forms#index'
  get '/forms/new' => 'forms#new'
  post '/forms' => 'forms#create'
  post '/upload' => 'forms#upload'
end
