

Then /^I should be on the (project show page for "[^"]*")$/ do |page_name|
    
    current_path.should == path_to(page_name) 

end



# viewing_projects.feature

=begin
        Perchè utilizzare Factory e non Project.create(:name=>name)? Se aggiungessimo un'altro campo alla tabella 
        projects, e se aggiungessimo una validazione sul campo, come ad esempio la presenza, allora dovremmo 
        cambiare tutte le occorrenze di Project.create perchè contengano il nuovo campo. Quando utilizziamo Factory
        eseguiamo questo cambiamento in un unico posto e cioè dove la factory è definita.  

      OSSERVAZIONE : Lo snippet di codice qui sotto l'ho sostituito con uno step in permission. 
      
      Given /^"([^"]*)" can view the "([^"]*)" project$/ do |user_email, project_name|
  
         Permission.create! :user  => User.find_by_email(user_email),
                            :thing => Project.find_by_name(project_name),
                            :action =>"view"   
  
       end



=end

Given /^There is a project called "([^"]*)"$/ do |name|

  @project = Factory(:project, :name=>name)

end




