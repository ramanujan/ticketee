Feature: Deleting tickets
 Affinchè si possano eliminare tickets associati ad un progetto
 Come un utente autenticato
 Voglio poter premere un pulsante nella pagina relativa al ticket ed eliminarlo.

Background: 
 
  Given there are the following users: 
   | email                  | password |
   | user@ticketee.com      | password |
  
  And I am signed in as "user@ticketee.com" 
  Given There is a project called "TextMate 2"
  And "user@ticketee.com" can view the "TextMate 2" project
  
  And "user@ticketee.com" has created a ticket for this project:
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
  