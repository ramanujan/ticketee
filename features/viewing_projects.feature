Feature: Viewing projects
 
 Al fine di avere dei progetti a cui assegnare tickets,
 Come un utente autenticato dell'applicazione
 
 Voglio essere in grado di vedere una lista di progetti a me disponibili in lettura, 
 quando sono sulla homepage. I progetti disponibili sono quelli cui io sono 
 iscritto.
 
 Da questa lista devo essere in grado di accedere ai dettagli riguardo
 il progetto desiderato, su di cui ho l'adeguato permesso. 

Background:   
  Given there are the following users:
  | email              | password |
  | user1@ticketee.com | password |
  | user2@ticketee.com | password |
  And There is a project called "TextMate 2"
  And There is a project called "Internet Explorer"
  And "user1@ticketee.com" can view the "TextMate 2" project 
 

Scenario: Listing only all projects available to users
 And I am signed in as "user1@ticketee.com"
 And I am on the homepage
 Then I should see "TextMate 2"
 And I should not see "InternetExplorer"
 Given I follow "TextMate 2"
 Then I should be on the project show page for "TextMate 2"

 