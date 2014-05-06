class AdminController < ApplicationController
  before_filter :admin_check
  
  def index
    @customer = Customer.count
    @city = City.count
  end
  
  def cities
    @cities = City.order 'name'
  end
  
  def add_city
    if City.where(:name => params[:name].capitalize).blank?
      city = City.new
      city.name = params[:name].capitalize
      city.save
      flash[:notice] = "#{city.name} was added successfully."
    else
      flash[:alert] = "#{params[:name]} is already exists."
    end
    redirect_to :back
  end
  
  def edit_city
    @city = City.find params[:id]
  end
  
  def update_city
    if City.where(:name => params[:name].capitalize).blank?
      city = City.find params[:city_id]
      city.name = params[:name].capitalize
      city.save
      flash[:notice] = "#{city.name} was updated successfully."
      redirect_to :action => "cities"
    else
      flash[:alert] = "#{params[:name]} is already exists."
      redirect_to :back
    end
  end
  
  def customers
    @customers = Customer.order 'name'
    @cities = City.order 'name'
  end
  
  private
  
  def admin_check
    if session[:admin] != "ADMIN"
      redirect_to :action => "index", :controller => "home"
    end
  end
end
