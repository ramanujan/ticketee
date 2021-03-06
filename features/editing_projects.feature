Feature: Editing Projects
 Per aggiornare i dati relativi ad un progetto,
 Come un amministratore
 Voglio essere in grado di farlo attraverso una comoda interfaccia
 
Background:
Given there are the following users:
 | email                      | password     |admin|
 | administrator@ticketee.com | password     |true |
 
 And I am signed in as "administrator@ticketee.com" 
 
Scenario: Updating a project

 Given There is a project called "TextMate 2"
 And I am on the homepage
 When I follow "TextMate 2"
 And I follow "Edit Project"
 And I fill in "Name" with "New TextMate 2"
 And I press "Update Project"
 Then I should see "Project has been updated."
 Then I should be on the project show page for "New TextMate 2" 
 
