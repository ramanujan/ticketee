Feature: Viewing projects
 Al fine di avere dei progetti a cui assegnare tickets,
 come un normale utente dell'applicazione
 voglio essere in grado di vedere una lista di progetti disponibili, 
 quando sono sulla homepage.
 Da questa lista devo essere in grado di accedere ai dettagli riguardo
 il progetto desiderato.  

Scenario: Listing all projects
 Given There is a project called "TextMate 2"
 And I am on the homepage
 When I follow "TextMate 2"
 Then I should be on the project show page for "TextMate 2"

 