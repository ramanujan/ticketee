Feature: Hidden links
 Affinchè l'interfaccia rimanga consistente con i privilegi di autorizzazione
 Come sistema 
 Voglio nascondere i links su cui l'utente non autorizzato non può agire

Background:
  Given there are the following users:
    | email                  | password   |admin|
    | user@ticketee.com      | password   |false|
    | admin@ticketee.com     | password   |true |
  And There is a project called "TextMate 2"
  And "user@ticketee.com" can view the "TextMate 2" project 
  And "user@ticketee.com" has created a ticket for this project:
  | title         | description                 |	
  |Make it shiny! |Gradients! Starbursts! Oh my!| 

Scenario: New Project link is hidden for non-signed-in users
  Given I am on the homepage 
  Then I should not see "New Project" link

Scenario: New Project link is hidden for normal-signed-in users
  Given I am signed in as "user@ticketee.com" 
  Then I should not see "New Project" link 
 
Scenario: New Project link is visible to admins 
  Given I am signed in as "admin@ticketee.com" 
  Then I should see "New Project" link 
 
Scenario: Edit Project link is hidden for non-signed-in users
  Given I am on the homepage 
  Then I should not see "TextMate 2" link
  And I should not see "Edit Project"
    
Scenario: Edit Project link is hidden for normal-signed-in users
  Given I am signed in as "user@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should not see "Edit Project" link

Scenario: Edit Project link is visible to admins users
  Given I am signed in as "admin@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should see "Edit Project" link

Scenario: Delete Project link is hidden for non-signed-in users
  Given I am on the homepage 
  Then I should not see "TextMate 2" link
  And I should not see "Delete Project"
    
Scenario: Edit Project link is hidden for normal-signed-in users
  Given I am signed in as "user@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should not see "Delete Project" link

Scenario: Edit Project link is visible to admins users
  Given I am signed in as "admin@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should see "Delete Project" link
 
Scenario: New Ticket link is visible only to a user which has a permission
    
  Given I am signed in as "user@ticketee.com"
  Given "user@ticketee.com" can create tickets on the "TextMate 2" project
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should see "New Ticket" link

Scenario: New Ticket link is hidden from a user which hasn't a permission
    
  Given I am signed in as "user@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should not see "New Ticket" link

Scenario: New Ticket link is visible to admins 
  Given I am signed in as "admin@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  Then I should see "New Ticket" link
 
 
Scenario: Edit Ticket link is visible only to a user which has a permission
    
  Given I am signed in as "user@ticketee.com"
  Given "user@ticketee.com" can edit tickets on the "TextMate 2" project
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should see "Edit Ticket" link

Scenario: Edit Ticket link is hidden from a user which hasn't a permission
    
  Given I am signed in as "user@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should not see "Edit Ticket" link

Scenario: Edit Ticket link is visible to admins 
  Given I am signed in as "admin@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should see "Edit Ticket" link

Scenario: Delete Ticket link is visible only to a user which has a permission
  Given I am signed in as "user@ticketee.com"
  Given "user@ticketee.com" can delete tickets on the "TextMate 2" project
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should see "Delete Ticket" link

Scenario: Delete Ticket link is hidden from a user which hasn't a permission
  Given I am signed in as "user@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should not see "Delete Ticket" link

Scenario: Delete Ticket link is visible to admins 
  Given I am signed in as "admin@ticketee.com"
  Given I am on the homepage 
  And I follow "TextMate 2"
  And I follow "Make it shiny!"
  Then I should see "Delete Ticket" link
 
