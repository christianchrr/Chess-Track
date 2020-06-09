require './config/environment'

class MovesController < ApplicationController
    
    get '/moves' do
        @moves = Move.all
        erb :"moves/index"
    end

    get '/moves/new' do
        erb :"moves/new"
    end

    post '/moves' do
        move = Move.create(params[:move])
        move.user_id = session[:user_id]
        move.save
        redirect to "/moves/#{move.id}"
    end

    get '/moves/:id' do
        id = params[:id]
        @move = Move.find_by(id: id)
        erb :"/moves/show"
    end

    get '/moves/:id/edit' do
        @move = Move.find_by(id: params[:id])
        erb :"/moves/edit"
    end

    put '/moves/:id' do
        move = Move.find_by(id: params[:id])
        move.update(params[:move])
        redirect to "/moves/#{move.id}"
    end

    delete '/moves/delete' do
        if current_user
            current_user.moves.each do |move|
                move.delete
            end
        end
        redirect to '/moves'
    end

    delete '/moves/:id' do
        move = Move.find_by(id: params[:id])
        move.destroy
        redirect to "/moves"
    end

end