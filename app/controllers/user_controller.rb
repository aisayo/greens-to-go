class UserController < ApplicationController

    get '/users/signup' do 
      if !logged_in? 
         erb :'/users/signup'
      else  
         redirect "/users/#{session[:user_id]}"
      end 
    end 

    post '/users/signup' do
      if params[:username] == "" && params[:password] == ""
         redirect "/users/signup"
      else 
         @user = User.create(
         username: params[:username], 
         password: params[:password]
      )
         session[:user_id] = @user.id 
         redirect "/users/#{@user.id}"
      end 
     end 


     get '/users/login' do 
      if !logged_in? 
         erb :'/users/login'
      else
         @user = User.find(session[:user_id])
         redirect "/users/#{@user.id}"
      end 
     end 


     post '/users/login' do 
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id 
         redirect "/users/#{@user.id}"
      else  
         redirect "/users/login"
      end 

     end 

     get '/users/:id' do 
        @user = User.find(params[:id])
        erb :'/users/show'
     end 

     get '/logout' do 
      session.clear
      redirect '/users/login'
     end 


end 


