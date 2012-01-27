Feature: Viewing tickets
 Affinchè si possano visualizzare i tickets associati ad un progetto
 Come un normale utente autenticato
 Voglio vederli nella pagina relativa al progetto
 
Background: 
  Given there are the following users: 
  | email                  | password |
  | user@ticketee.com      | password |
 
  And There is a project called "TextMate 2"
  And "user@ticketee.com" can view the "TextMate 2" project
  And "user@ticketee.com" has created a ticket for this project:
   | title         | description                 |	
   |Make it shiny! |Gradients! Starbursts! Oh my!|
  
  And There is a project called "Internet Explorer"
  And "user@ticketee.com" has created a ticket for this project:
   | title                | description   |            	
   | Standards compliance | Isn't a joke. |
  And I am signed in as "user@ticketee.com"
  And I am on the homepage

Scenario: Viewing tickets for a given project

 When I follow "TextMate 2"
 Then I should see "Make it shiny!"
 And I should not see "Standard compliance"
 
 When I follow "Make it shiny!"
 Then I should see "Make it shiny!" within "#ticket_title_field h2"
 And I should see "Gradients! Starbursts! Oh my!" 
 And I should see "Created by user@ticketee.com"
