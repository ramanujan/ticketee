Feature: Editing tickets
 Affinchè si possano aggiornare i dati relativi ad un ticket
 Come un normale utente
 Voglio poterlo fare tramite una comoda form 
 Attivabile in maniera semplice dalla pagina relativa al ticket
 
Background: 
 Given There is a project called "TextMate 2"
 And that project has a ticket:
 | title         | description                 |	
 |Make it shiny! |Gradients! Starbursts! Oh my!|
 
 Given I am on the homepage
 When I follow "TextMate 2"
 And I follow "Make it shiny!"
 And I follow "Edit Ticket"

Scenario: Updating a ticket

 When I fill in "Ticket title" with "Make it really shiny!!"
 And I press "Update Ticket"
 Then I should see "Ticket has been updated."
 And I should see "Make it really shiny!!" within "#ticket_title_show h2"     
 But I should not see "Make it shiny!"
