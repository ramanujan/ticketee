Given /^(?:|I )am on (.+)$/ do |page_name|
  
  visit path_to(page_name) #path_to è definito in features/support/paths.rb nel modulo NavigationHelpers
  
end

When /^I follow "([^"]*)"$/ do |arg1|
   click_link arg1 # scan id,text or value  
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
 fill_in arg1, :with=>arg2 
end

When /^I press "([^"]*)"$/ do |arg1|
  click_button(arg1) # finds a button by id,text,value and clicks it
end

Then /^I should see "([^"]*)"$/ do |arg1|

  page.has_content? arg1

end