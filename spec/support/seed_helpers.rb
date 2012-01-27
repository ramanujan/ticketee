module SeedHelpers 
 
 def create_user! attributes={}
    p "DENTRO CREATE USER !"
    user = Factory(:user,attributes)
    p "CREATED USER : #{user}"
    user.confirm!
    user
  end
  
end



RSpec.configure do |config|
  
  config.include SeedHelpers
  
end