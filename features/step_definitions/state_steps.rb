Given /^there is a state called "([^"]*)"$/ do |name|

 Factory(:state, :name=>name)
 #State.create!(:name=>name) 
end

