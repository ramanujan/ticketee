Given /^I am on the (.+)$/ do |page_name|
  
  visit path_to(page_name) #path_to è definito in features/support/paths.rb nel modulo NavigationHelpers
  
end

When /^I follow "([^"]*)"$/ do |arg1|
  
  click_link arg1 # capybara scans id,text or value  

end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|

 fill_in arg1, :with=>arg2 

end


When /^I press "([^"]*)"$/ do |arg1|

  click_button(arg1) # finds a button by id,text,value and clicks it

end

Then /^I should see "([^"]*)"$/ do |arg1|  
  
  page.should have_content arg1
   
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should have_no_content arg1
end


Then /^I should see "([^"]*)" within "([^"]*)"$/ do |arg1, arg2|
  
  
  page.should have_css(arg2,:text=>arg1), 
                      "Expected to see #{arg1.inspect} inside #{arg2}, but did not."

end


=begin

  Nello step seguente, sto utilizzando una funzionalità di Capybara che è 
  attach_file(). attach_file() dice a Capybara di cercare un campo file
  ( file field in page ) e di attaccare ( come allegato ) il file specificato 
  dal path. Si noti che la ricerca del campo file avviene come al solito,
  cioè è una ricerca per name,id,label. 
         
=end


When /^I attach the file "([^"]*)" to "([^"]*)"$/ do |path,file_field|

  attach_file(file_field,path)

end


Given /^I am signed in as "([^"]*)"$/ do |email|
  steps %Q{ Given I am on the homepage 
            When I follow "Login" 
            And I fill in "Email" with "#{email}"  
            And I fill in "Password" with "password" 
            And I press "Login" 
            Then I should see "Signed in successfully."}
end



When /^I check "([^"]*)"$/ do |arg1|

  check(arg1)

end


Then /^show me the page$/ do

  save_and_open_page

end



