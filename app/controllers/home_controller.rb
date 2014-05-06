class HomeController < ApplicationController
  def index
  end
  
  def user_login
  	if params[:name] == "user" && params[:password] == "password"
  	  flash[:notice] = "User logging successful."
  	  session[:user] = "USER"
  	  redirect_to :action => "index", :controller => "user"
  	else
  	  flash[:alert] = "User login failed."
  	  redirect_to :action => "index"
  	end
  end
  
  def admin_login
    if params[:name] == "admin" && params[:password] == "password"
      flash[:notice] = "Admin logging successful."
      session[:admin] = "ADMIN"
      redirect_to :action => "index", :controller => "admin"
    else
      flash[:alert] = "Admin login failed."
      redirect_to :action => "index"
    end
  end
  
  def logout
    reset_session
    flash[:notice] =  "Logged out successfully."
    redirect_to :action => "index"
  end
end
