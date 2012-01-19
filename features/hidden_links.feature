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
   And I follow "TextMate 2"
   Then I should not see "Edit Project" link
 
Scenario: Edit Project link is hidden for normal-signed-in users
    Given I am signed in as "user@ticketee.com"
    Given I am on the homepage 
    And I follow "TextMate 2"
    Then I should not see "Edit Project" link


Scenario: Edit Project link is visible for admins users
    Given I am signed in as "admin@ticketee.com"
    Given I am on the homepage 
    And I follow "TextMate 2"
    Then I should see "Edit Project" link

Scenario: Delete Project link is hidden for non-signed-in users
   Given I am on the homepage 
   And I follow "TextMate 2"
   Then I should not see "Delete Project" link
 
Scenario: Edit Project link is hidden for normal-signed-in users
    Given I am signed in as "user@ticketee.com"
    Given I am on the homepage 
    And I follow "TextMate 2"
    Then I should not see "Delete Project" link

Scenario: Edit Project link is visible for admins users
    Given I am signed in as "admin@ticketee.com"
    Given I am on the homepage 
    And I follow "TextMate 2"
    Then I should see "Delete Project" link
 


