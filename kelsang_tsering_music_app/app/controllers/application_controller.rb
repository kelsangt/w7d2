class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :login!

    def current_user 
        current_user = User.find_by(session_token: session[:session_token])
    end

    def logged_in? 
        if User.exists?(session_token: session[:session_token])
            return true 
        else 
            return false 
        end
    end

    def login!(user)
        user.reset_session_token!
    end
end
