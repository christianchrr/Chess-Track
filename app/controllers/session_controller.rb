class SessionController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect to '/moves'
    else
      erb :"/sessions/signup"
    end
  end
  
  # get '/login' do
  #   erb :"sessions/login"
  # end
  
  post '/signup' do
    user = User.new(params[:user])
    # binding.pry
    if !user.save
      @error = user.errors.full_messages.join(" ")
      erb :"/sessions/signup"
    else
      session[:user_id] = user.id
      redirect to '/moves'
    end
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/moves'
    else
      @error = "Incorrect username or password."
      erb :welcome
    end
  end
  
  get '/logout' do
    session[:user_id] = nil
    redirect to "/"
  end
  
end