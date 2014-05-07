task :add_customers => :environment do
  puts "Started....."
  file = File.read("#{Rails.root}/customers.csv")
  puts "customers.csv file loaded"
  customers = file.split("\n")
  puts "customers count = #{customers.count}"
  puts "adding customers....please wait..."
  customers.each do |customer|
    c = customer.split(",")
    cust = Customer.new
    cust.name = c[2].strip.capitalize
    cust.number = c[4].strip
    cust.email = c[5].strip unless c[5].blank?
    city = City.where(:name => c[1].strip.capitalize).first
    if city.blank?
      city = City.new
      city.name = c[1].strip.capitalize
      city.save
    end
    cust.city = city
    designation = Designation.where(:name => c[0].strip.upcase).first
    if designation.blank?
      designation = Designation.new
      designation.name = c[0].strip.upcase
      designation.save
    end
    cust.designation = designation
    cust.save
  end
  puts "customers addition done...."
  puts ".....Ended"
end
