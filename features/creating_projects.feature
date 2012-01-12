Feature: Creating projects
 Al fine di avere dei progetti a cui assegnare tickets,
 come un normale utente dell'applicazione
 li voglio creare facilmente. In pratica 
 voglio poter premere un pulsante per richiedere la creazione
 del progetto, riempire la form che appare e quindi creare il 
 progetto.

Background:
 Given I am on the homepage
 When I follow "New Project"

Scenario: Creating a project
 And I fill in "Name" with "TextMate 2"
 And I press "Create Project"
 Then I should be on the project show page for "TextMate 2"
 And I should see "Project has been created."
 And I should see "Showing project: TextMate 2 - Ticketee"

Scenario: Creating a project without name
 And I press "Create Project" 
 Then I should see "Project has not been created."
 And I should see "Name can't be blank"


Scenario: Creating a project with a duplicate name
 Given There is a project called "TextMate 2"
 And I fill in "Name" with "TextMate 2"
 And I press "Create Project"
 Then I should see "Project has not been created."
 And I should see "Name has already been taken"
