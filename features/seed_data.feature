Feature: Seed Data
 Affinchè si possa riempire il database con dei dati di base
 Come sistema 
 Voglio eseguire il task seed
 
Scenario: The Basic data
Given I have run the seed task
And I am signed in as "admin@ticketeefoodomain123.com"
Then I should see "Ticketee_3_project"

