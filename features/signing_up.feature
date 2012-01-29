Feature: Signing up
 
 Affinchè possa lavorare ai progetti
 Come un normale utente
 Voglio potermi registrare facilmente

Scenario: Sign up

 Given I am on the homepage 
 When I follow "Sign up"
 And I fill in "Email" with "user@ticketee.com"
 And I fill in "Password" with "password"
 And I fill in "Password confirmation" with "password"
 And I press "Sign up"
 Then I should see "You have signed up successfully."
 Then I should see "You can confirm your account through the link below:" 