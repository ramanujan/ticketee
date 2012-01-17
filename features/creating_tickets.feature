Feature: Creating tickets
 Affinchè si possano assegnare tickets ai progetti
 Come un utente autenticato dell'applicazione
 Voglio poter selezionare un progetto e creare il nuovo ticket. 
 Ogni utente autenticato può associare un ticket ad uno qualunque dei progetti presenti. 
 
Background:
  Given There is a project called "Internet Explorer"
  And there are the following users: 
  | email                  | password |
  | user@ticketee.com      | password |
  
  And I am on the homepage
  When I follow "Internet Explorer"
  And I follow "New Ticket"
  Then I should see "You need to sign in or sign up before continuing."
  When I fill in "Email" with "user@ticketee.com" 
  And I fill in "Password" with "password" 
  And I press "Login"
  Then I should see "Create a ticket for project: Internet Explorer"	         

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
    
