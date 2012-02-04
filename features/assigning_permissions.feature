Feature: Assigning permissions
 Affinchè si possano organizzare i permessi corretti per tutti gli utenti
 Come utente amministratore 
 Voglio poterlo fare tramite checkbox
 
Background:
 Given there are the following users:
 | email              | password | admin |
 | admin@ticketee.com | password | true  |
 
 And I am signed in as "admin@ticketee.com"
 
 And there are the following users:
 | email               | password |
 |user@ticketee.com    | password |
 |user_bis@ticketee.com| password |
 
 And There is a project called "TextMate 2"
 And "user_bis@ticketee.com" has created a ticket for this project: 
 | title         | description                 |	
 |Make it shiny! |Gradients! Starbursts! Oh my!|
 
 When I follow "Admin"
 And I follow "Users"
 And I follow "user@ticketee.com"
 And I follow "Permissions"

Scenario: Viewing a project
 When I check "View" for "TextMate 2"
 And I press "Update"
 And I follow "Logout"
 Given I am signed in as "user@ticketee.com"
 Then I should see "TextMate 2"

Scenario: Creating tickets for a project 
 When I check "View" for "TextMate 2"
 And I check "Create tickets" for "TextMate 2"
 And I press "Update"
 And I follow "Logout"
 Given I am signed in as "user@ticketee.com"
 And I follow "TextMate 2"
 Then I should see "New Ticket"
 Given I follow "New Ticket"
 And I fill in "Ticket title" with "Shiny!"
 And I fill in "Description" with "Make it so!"
 And I press "Create Ticket"
 Then I should see "Ticket has been created." 


Scenario: Updating tickets for a project 
 When I check "View" for "TextMate 2"
 And I check "Edit tickets" for "TextMate 2"
 And I press "Update"
 And I follow "Logout"
 
 Given I am signed in as "user@ticketee.com"
 And I follow "TextMate 2"
 Then I follow "Make it shiny!"
 And I follow "Edit Ticket"
 And I fill in "Ticket title" with "Very very shiny!"
 And I fill in "Description" with "Make it so, right now!"
 And I press "Update Ticket"
 Then I should see "Ticket has been updated." 


