Rails.application.routes.draw do
  get '/' => 'forms#new'
  get '/forms/new' => 'forms#new'
  post '/upload' => 'forms#upload'
end
