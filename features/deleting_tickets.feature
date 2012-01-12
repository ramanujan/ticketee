Feature: Deleting tickets
 Affinchè si possano eliminare tickets associati ad un progetto
 Come un normale utente
 Voglio poter premere un pulsante nella pagina relativa al ticket ed eliminarlo.

Background: 
 Given There is a project called "TextMate 2"
 And that project has a ticket:
 | title         | description                 |	
 |Make it shiny! |Gradients! Starbursts! Oh my!|
 
 Given I am on the homepage
 When I follow "TextMate 2"
 And I follow "Make it shiny!"

Scenario: Deleting a ticket
 And I follow "Delete Ticket"
 Then I should see "Ticket has been deleted."
 And I should be on the project show page for "TextMate 2"
 And I should not see "Make it shiny!"
  