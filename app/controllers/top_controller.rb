class TopController < ApplicationController
    def main
        if session[:login_uid]
            render 'main'
        else
            render 'login'
        end
    end
        
    def login
        if user = User.find_by(uid: params[:uid])
            if BCrypt::Password.new(user.pass) == params[:pass]
                session[:login_uid] = params[:uid]
                redirect_to root_path
            else
            render 'login_failed'
            end
        end
    end
    
    def logout
        session.delete(:login_uid)
        redirect_to root_path
    end
end
