class SessionsController < ApplicationController
    def new
        @user = User.new 
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]
        @user = User.find_by_credentials(username, password)
        if @user
            login!(@user)
            redirect_to posts_url
        else
            flash.now[:errors] = ["Invalid credentials!"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end