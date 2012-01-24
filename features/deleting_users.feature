Feature: Deleting users
 
 Affinchè si possa cancellare un utente dall'applicazione
 Come amministratore
 Voglio poterlo fare semplicemente. 
 In effetti desidero premere un pulsante e cancellarlo.
 
Background: 

 Given there are the following users:
  | email              | password | admin |
  | admin@ticketee.com | password | true  |
  | user@ticketee.com  | password | false | 
 And I am signed in as "admin@ticketee.com" 
 Given I am on the homepage
 When I follow "Admin"
 And I follow "Users"
 
Scenario: Deleting a user 
 
 And I follow "user@ticketee.com"
 And I follow "Delete User"
 Then I should see "User has been deleted."
 Then I should not see "user@ticketee.com"

Scenario: Administrator cannot deleting themeselves 
 And I follow "admin@ticketee.com"
 And I follow "Delete User"
 Then I should see "You cannot delete yourself! :-) "
   