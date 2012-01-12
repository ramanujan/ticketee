Feature: Viewing tickets
 Al fine di vedere quali tickets sono associati ad un progetto
 Come un normale utente
 voglio vederli nella pagina relativa al progetto
 
Background: 
 
 Given There is a project called "TextMate 2"
 And that project has a ticket:
 | title         | description                 |	
 |Make it shiny! |Gradients! Starbursts! Oh my!|
 
 And There is a project called "Internet Explorer"
 And that project has a ticket:
 | title                | description   |            	
 | Standards compliance | Isn't a joke. |
 
 And I am on the homepage

Scenario: Viewing tickets for a given project

 When I follow "TextMate 2"
 Then I should see "Make it shiny!"
 And I should not see "Standard compliance"
 When I follow "Make it shiny!"
 Then I should see "Make it shiny!" within "#ticket_title_show h2"
 And I should see "Gradients! Starbursts! Oh my!" 
