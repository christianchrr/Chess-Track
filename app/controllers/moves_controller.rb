require './config/environment'

class MovesController < ApplicationController
    
    get '/moves' do
        if logged_in
            @moves = current_user.moves
            erb :"/moves/index"
        else 
            redirect to '/'
        end
    end

    get '/moves/new' do
        if logged_in
            erb :"/moves/new"
        else
            redirect to '/'
        end
    end

    post '/moves' do
        move = Move.create(params[:move])
        move.user_id = session[:user_id]
        move.save
        redirect to "/moves/#{move.id}"
    end

    get '/moves/:id' do
        id = params[:id]
        if !logged_in
            redirect to '/'
        end
        @move = current_user.moves.find_by(id: id)
        if @move
            erb :"/moves/show"
        else
            redirect to "/moves"
        end
    end

    get '/moves/:id/edit' do
        if !logged_in
            redirect to '/'
        end
        @move = Move.find_by(id: params[:id])
        if @move.user = current_user 
            erb :"/moves/edit"
        else
            redirect to "/moves"
        end
    end

    put '/moves/:id' do
        move = current_user.moves.find_by(id: params[:id])
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
        move = current_user.moves.find_by(id: params[:id])
        move.destroy
        redirect to "/moves"
    end

end