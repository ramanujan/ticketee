Given /^I am on the (.+)$/ do |page_name|
  
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

Then /^I should be on the (project show page for "[^"]*")$/ do |page_name|
    
    current_path.should == path_to(page_name) 

end

Then /^I should see "([^"]*)"$/ do |arg1|

  page.should have_content arg1

end

# viewing_projects.feature

=begin
        Perchè utilizzare Factory e non Project.create(:name=>name)? Se aggiungessimo un'altro campo alla tabella 
        projects, e se aggiungessimo una validazione sul campo, come ad esempio la presenza, allora dovremmo 
        cambiare tutte le occorrenze di Project.create perchè contengano il nuovo campo. Quando utilizziamo Factory
        eseguiamo questo cambiamento in un unico posto e cioè dove la factory è definita.  
=end

Given /^There is a project called "([^"]*)"$/ do |name|

  Factory(:project, :name=>name)

end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should have_no_content arg1
end
