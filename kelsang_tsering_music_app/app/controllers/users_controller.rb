class UsersController < ApplicationController 
    def sign_up(email_address, password)
        user = User.new(email_address: email_address)
        user.session_token = user.generate_unique_session_token
        user.password = password
        if user.save!
            login(user)
        end
    end
end