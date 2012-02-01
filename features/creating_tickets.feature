Feature: Creating tickets

 Affinchè si possano assegnare tickets ai progetti
 Come un utente autenticato dell'applicazione
 Voglio poter selezionare un progetto e creare il nuovo ticket. 
 Ogni utente autenticato può creare un ticket solo su progetti su cui ha il permesso di farlo.
 

Background:
  Given There is a project called "Internet Explorer"
  And there are the following users: 
  | email                  | password |
  | user@ticketee.com      | password |
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
    
