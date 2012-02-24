Given /^"([^"]*)" has created a ticket for this project:$/ do |email, table|
 

=begin

  table is a Cucumber::Ast::Table
  
  Cucumber fornisce il metodo Table#hashes() che utilizza la prima riga nella tabella creata
  nella descrizione della feature come chiavi | title | description |
  e le righe rimanenti come valori degli hashes salvati in un array. In pratica ritorna:
  
  [{"title"=>"Make it shiny!", "description"=>"Gradients! Starbursts! Oh my!"}]
    
  
  Si noti inoltre che in questo step utilizzo @project che è stato caricato dallo step
  precedente "And There is a project called TextMate 2"
    
=end  
   
   table.hashes.each do |ticket_attr|
     
      @project.tickets.create! ticket_attr.merge!(:user=>User.find_by_email!(email) )

   end

end



=begin
    
    Si noti che il seguente step: 
           
           Given /^"([^"]*)" can create tickets in the "([^"]*)" project$/ do |user_email, project_name|
                     Permission.create! :user  => User.find_by_email(user_email),
                     :thing => Project.find_by_name(project_name),
                     :action =>"create tickets"   
            end

    è simile allo step definito in project_steps:
    
          Given /^"([^"]*)" can view the "([^"]*)" project$/ do |user_email, project_name|
           
                      Permission.create! :user  => User.find_by_email(user_email),
                      :thing => Project.find_by_name(project_name),
                      :action =>"view"   
    
    Allora invece di scrivere questo step qui, siamo DRY e andiamo a scrivere un nuovo insieme di 
    steps che chiameremo permission_steps. (si veda permission_steps.rb)
             
=end





