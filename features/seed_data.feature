Feature: Seed Data
 Affinchè si possa riempire il database con dei dati di base
 Come sistema 
 Voglio eseguire il task seed
 
Background:
  Given I have run the seed task
  And I am signed in as "admin@ticketeefoodomain123.com"

Scenario: Projects exists
  Then I should see "Ticketee_3_project"

Scenario: Some state exists 
  When I follow "Ticketee_3_project"
  And I follow "New Ticket"
  And I fill in "Ticket title" with "Comments with state"
  And I fill in "Description" with "We want to comment a ticket and adding a state"
  And I press "Create Ticket"
  Then I should see "Ticket has been created."
  And I should see "New" within "#comment_state_id" 
  And I should see "Open" within "#comment_state_id" 
  And I should see "Closed" within "#comment_state_id" 
  