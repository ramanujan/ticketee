Feature: Signing in
 Affinchè possa utilizzare questa applicazione
 Come un normale utente iniziale
 devo essere in grado di eseguire il login
 
Background: 
 Given there are the following users:
    
    | email                  | password   |unconfirmed|
    | user@ticketee.com      | password   |false      |
    | unconfirmed@ticketee.com | password |true       |
    
Scenario: Login via confirmation
  And "unconfirmed@ticketee.com" opens the email with subject "Confirmation instructions"
  And they click the first link in the email
  Then I should see "Your account was successfully confirmed"
  And I should see "Signed in as unconfirmed@ticketee"

Scenario: Signing in via form
   And I am signed in as "user@ticketee.com" 
  
    