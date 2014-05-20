class UserController < ApplicationController
  def index
    redirect_to :action => "customers"
  end
  
  def customers
    @customers = Customer.order 'name'
    @cities = City.order 'name'
    @designations = Designation.order 'name'
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
  
  def call_customer
    @customer = Customer.find params[:id]
  end
  
  def get_time
    render :text => Time.now
  end
  
  def save_activity
    if !params[:start_time].blank? && !params[:end_time].blank?
      customer = Customer.find params[:customer_id]
      activity = Activity.new
      activity.start_time = params[:start_time]
      activity.end_time = params[:end_time]
      activity.feedback = params[:feedback]
      activity.customer = customer
      activity.save
      flash[:notice] = "#{customer.name} Call Details Saved Successfully."
      redirect_to :action => "customers"
    else
      flash[:alert] = "Either Start Call or End Call not yet done."
      redirect_to :back
    end
  end
  
  def add_job
    @customer = Customer.find params[:id]
  end
  
  def save_job
    @customer = Customer.find params[:customer_id]
    job = Job.new
    job.description = params[:description]
    job.due_date = params[:due_date]
    job.status = params[:status]
    job.payment_status = params[:payment_status]
    job.customer = @customer
    job.save
    flash[:notice] = "Job added successfully for #{@customer.name}."
    redirect_to :action => "customers"
  end
  
  def view_jobs
    @customer = Customer.find params[:id]
    @jobs = @customer.jobs.order 'due_date DESC'
  end
  
  private
  
  def admin_check
    if session[:user] != "USER"
      redirect_to :action => "index", :controller => "home"
    end
  end
end
