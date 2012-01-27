Feature: Viewing projects
 
 Al fine di avere dei progetti a cui assegnare tickets,
 Come un utente autenticato dell'applicazione
 
 Voglio essere in grado di vedere una lista di progetti a me disponibili in lettura, 
 quando sono sulla homepage.
 
 Da questa lista devo essere in grado di accedere ai dettagli riguardo
 il progetto desiderato, su di cui ho l'adeguato permesso. 

Background:   
  Given there are the following users:
  | email              | password |
  | user@ticketee.com  | password |
  And I am signed in as "user@ticketee.com"
  And There is a project called "TextMate 2"
  And "user@ticketee.com" can view the "TextMate 2" project 

Scenario: Listing all projects
 And I am on the homepage
 When I follow "TextMate 2"
 Then I should be on the project show page for "TextMate 2"

 