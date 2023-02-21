class User < ApplicationRecord 
    validates :email_address, presence: true, uniqueness: true
    before_validation :generate_unique_session_token

    def generate_unique_session_token
        session[:session_token] = SecureRandom.urlsafe_base64 
        self.save!
    end

    def reset_session_token!
        generate_unique_session_token
    end

    def ensure_session_token
        while User.exists?(:session_token == session[:session_token])
            generate_unique_session_token
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcypt = BCrypt::Password.create(self.password_digest)
        bcypt.is_password?(password)
    end

    def self.find_by_credentials(email, password)
        @user = User.find_by(email_address: email)
        return @user if is_password?(password)
    end


end