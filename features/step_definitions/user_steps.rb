Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  @users=[]
  
  table.hashes.each do |attributes|
     @users << (User.create! attributes)     
  end

end
