Feature: Creating tickets
  Affinchè si possano assegnare tickets ai progetti
  Come un utente autenticato dell'applicazione
  Voglio poter selezionare un progetto e creare il nuovo ticket. 
  Ogni utente autenticato può creare un ticket solo su progetti su cui ha il permesso di farlo.

Background:
  Given There is a project called "Internet Explorer"
  And there are the following users: 
  | email                  | password |admin|
  | user@ticketee.com      | password |false|
  | admin@ticketee.com     | password |true |
  And "user@ticketee.com" can view the "Internet Explorer" project
  And "user@ticketee.com" can create tickets on the "Internet Explorer" project
  
  And I am signed in as "user@ticketee.com"
  And I am on the homepage
  When I follow "Internet Explorer"
  And I follow "New Ticket"
  
Scenario: Creating a ticket
  When I fill in "Ticket title" with "Non-standards compliance"
  And I fill in "Description" with "My pages are ugly!"
  And I press "Create Ticket"
  Then I should see "Ticket has been created."
 
Scenario: Creating a ticket without an empty attribute
  And I press "Create Ticket"
  Then I should see "Ticket has not been created."
  And I should see "Title can't be blank"
  And I should see "Description can't be blank"
   
Scenario: Creating a ticket  with a long title 
  When I fill in "Ticket title" with "*************************************"
  And I press "Create Ticket"
  Then I should see "Ticket has not been created."
  And I should see "is too long (maximum is 30 characters)"

Scenario: Creating a ticket with a short description
  When I fill in "Ticket title" with "Non-standards compliance"
  And I fill in "Description" with "My page"
  And I press "Create Ticket"
  Then I should see "Ticket has not been created."
  And I should see "is too short (minimum is 8 characters)"

@javascript    
Scenario: Creating a ticket with an attachment
  When I fill in "Ticket title" with "Non-standards compliance"
  And I fill in "Description" with "With this ticket, we are able to attach some files."
  And I attach the file "test/fixtures/speed.txt" to "File #1"
  And I follow "Add another file"
  And I attach the file "test/fixtures/spin.txt" to "File #2"
  And I press "Create Ticket"
  Then I should see "Ticket has been created."
  Then I should see "speed.txt" within "div a"
  Then I should see "spin.txt" within "div a"
  When I follow "speed.txt"
