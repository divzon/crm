class AdminController < ApplicationController
  before_filter :admin_check
  
  def index
    @customer = Customer.count
    @city = City.count
    @designation = Designation.count
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
  
  def designations
    @designations = Designation.order 'name'
  end
  
  def add_designation
    if Designation.where(:name => params[:name].upcase).blank?
      designation = Designation.new
      designation.name = params[:name].upcase
      designation.save
      flash[:notice] = "#{designation.name} was added successfully."
    else
      flash[:alert] = "#{params[:name].upcase} is already exists."
    end
    redirect_to :back
  end
  
  def edit_designation
    @designation = Designation.find params[:id]
  end
  
  def update_designation
    if Designation.where(:name => params[:name].upcase).blank?
      designation = Designation.find params[:designation_id]
      designation.name = params[:name].upcase
      designation.save
      flash[:notice] = "#{designation.name} was updated successfully."
      redirect_to :action => "designations"
    else
      flash[:alert] = "#{params[:name].upcase} is already exists."
      redirect_to :back
    end
  end
  
  def customers
    @customers = Customer.order 'name'
    @cities = City.order 'name'
    @designations = Designation.order 'name'
  end
  
  def add_customer
    customer = Customer.new
    customer.name = params[:name]
    customer.email = params[:email]
    customer.number = params[:number]
    customer.city = City.find(params[:city]) unless params[:city].blank?
    customer.designation = Designation.find(params[:designation]) unless params[:designation].blank?
    customer.save
    flash[:notice] = "#{customer.name} was added successfully."
    redirect_to :back
  end
  
  def edit_customer
    @customer = Customer.find params[:id]
    @cities = City.order 'name'
    @designations = Designation.order 'name'
  end
  
  def update_customer
    customer = Customer.find params[:customer_id]
    customer.name = params[:name]
    customer.email = params[:email]
    customer.number = params[:number]
    customer.city = City.find(params[:city]) unless params[:city].blank?
    customer.designation = Designation.find(params[:designation]) unless params[:designation].blank?
    customer.save
    flash[:notice] = "#{customer.name} was updated successfully."
    redirect_to :action => "customers"
  end
  
  def delete_customer
    customer = Customer.find params[:id]
    customer.destroy
    flash[:info] = "#{customer.name} was deleted successfully."
    redirect_to :back
  end
  
  def search_customer
    @name = params[:name]
    @email = params[:email]
    @designation = params[:designation]
    @number = params[:number]
    @city = params[:city]
    query_string = []
    query_string << "name like '%#{@name}%'" unless @name.blank?
    query_string << "email like '%#{@email}%'" unless @email.blank?
    query_string << "number like '%#{@number}%'" unless @number.blank?
    query_string << "designation_id = '#{@designation}'" unless @designation.blank?
    query_string << "city_id = '#{@city}'" unless @city.blank?
    if query_string.blank?
      flash[:alert] = "Atleast one value is required to search."
      redirect_to :back
    else
      query = query_string.join(" and ")
      @customers = Customer.where(query).order 'name'
      if @customers.blank?
        flash[:info] = "No customers found in given criteria."
        redirect_to :back
      else
        @cities = City.order 'name'
        @designations = Designation.order 'name'
      end
    end
  end
  
  private
  
  def admin_check
    if session[:admin] != "ADMIN"
      redirect_to :action => "index", :controller => "home"
    end
  end
end
