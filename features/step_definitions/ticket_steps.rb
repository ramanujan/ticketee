Given /^that project has a ticket:$/ do |table|

=begin

  table is a Cucumber::Ast::Table
  
  Cucumber fornisce il metodo Table#hashes() che utilizza la prima riga nella tabella creata
  nella descrizione della feature come chiavi | title | description |
  e le righe rimanenti come valori degli hashes salvati in un array. In pratica ritorna:
  
  [{"title"=>"Make it shiny!", "description"=>"Gradients! Starbursts! Oh my!"}]
    
  
    
=end  
   
   table.hashes.each do |ticket_attr|
     
   @project.tickets.create! ticket_attr

   end

end

Then /^I should see "([^"]*)" within "([^"]*)"$/ do |arg1, arg2|
  
  within("#{arg2}") do
      page.should have_content arg1
  end

end