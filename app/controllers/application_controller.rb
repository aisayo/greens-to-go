require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret,  'secret'
  end

  get "/" do
    if logged_in?
      redirect "/users/#{session[:user_id]}"
    else 
      erb :welcome
    end
  end


  helpers do 

    def logged_in? #return a true of false value 
      !!session[:user_id]
    end 

    def current_user
      @current_user ||= User.find(session[:user_id])
    end 

  end 

end
