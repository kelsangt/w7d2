class SessionsController < ApplicationController 
    def login(user)
        if User.find_by_credentials(user.email_address, user.password)
            user.session_token = user.ensure_session_token
            session[:session_token] = user.session_token
        else 
            render :new 
        end
    end

    def logout(user)
        session[:session_token] = user.generate_unique_session_token
        user.reset_session_token!

    end

    def create 
        redirect_to user_url
    end

    def new
        render :new
    end
end