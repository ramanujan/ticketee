Feature: Creating comments
  Affinchè si possa aggiornare il workflow di un ticket
  Come utente con i relativi permessi
  Voglio poter lasciare un commento
  
Background: 
 Given there are the following users:
  | email              | password |
  | user@ticketee.com  | password | 
  
 And I am signed in as "user@ticketee.com"
 And There is a project called "Ticketee"
 And "user@ticketee.com" can view the "Ticketee" project
 And "user@ticketee.com" has created a ticket for this project:
   | title                   | description                            |
   | Change a ticket's state | You should be able to create a comment |
 
 Given I am on the homepage
 Given there is a state called "Open"
 And I follow "Ticketee"
 When I follow "Change a ticket's state"
 

Scenario: Creating a comment
  
  And I fill in "Add a comment:" with "Added a comment!"
  And I press "Create Comment"
  Then I should see "Comment has been created."
  Then I should see "Added a comment!" within "#comments"

Scenario: Creating an invalid comment
  And I press "Create Comment"
  Then I should see "Comment has not been created."
  Then I should see "can't be blank"
 
Scenario: Changing a ticket's state
  And I fill in "Add a comment:" with "This is a real issue!" 
  And I select "Open" from "State"
  And I press "Create Comment"
  Then I should see "Comment has been created."
  Then I should see "This is a real issue!" within "#comments"
  Then show me the page
  And I should see "Open" within "#ticket_info .state"
  
