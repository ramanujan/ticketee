Feature: Creating projects
 Al fine di avere dei progetti a cui assegnare tickets,
 come un normale utente dell'applicazione
 li voglio creare facilmente. In pratica 
 voglio poter premere un pulsante per richiedere la creazione
 del progetto, riempire la form che appare e quindi creare il 
 progetto.

Scenario: Creating a project
 
 Given I am on the homepage
 When I follow "New Project"
 And I fill in "Name" with "TextMate 2"
 And I press "Create Project"
 Then I should see "Project has been created."

