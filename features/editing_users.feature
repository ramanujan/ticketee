Feature: Editing users
 
 Affinchè si possano cambiare i dettagli di un utente 
 Come amministratore del sistema
 Voglio essere in grado di farlo attraverso una comoda interfaccia

Background: 

  Given there are the following users:
  | email              | password | admin |
  | admin@ticketee.com | password | true  |
  | user@ticketee.com  | password | false |
  
  And I am signed in as "admin@ticketee.com"
  And I am on the homepage
  When I follow "Admin"
  And I follow "Users"
  And I follow "user@ticketee.com"
  And I follow "Edit User"
     
Scenario: Updating a user's details
 
 When I fill in "Email" with "newguy@ticketee.com"
 And I fill in "Password" with "password"
 And I fill in "Password confirmation" with "password"
 And I press "Update User"
 Then I should see "User has been updated."
 And I should see "admin@ticketee.com (Administrator)"
 And I should not see "user@ticketee.com"
 And I should see "newguy@ticketee.com"

Scenario: Updating only user's email
 When I fill in "Email" with "newguy@ticketee.com"
 And I press "Update User"
 Then I should see "User has been updated."
 And I should see "admin@ticketee.com (Administrator)"
 And I should not see "user@ticketee.com"
 And I should see "newguy@ticketee.com"

Scenario: Toggling a user's admin ability 
  When I check "Is an admin?"
  And I press "Update User"
  Then I should see "User has been updated."
  And I should see "admin@ticketee.com (Administrator)"
  And I should see "user@ticketee.com (Administrator)"