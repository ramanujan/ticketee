Feature: Deleting projects
  Affinchè si possano rimuovere i progetti di cui
  non si ha più bisogno
  Come un utente che ha il ruolo di project manager
  devo poter eliminare facilmente. In pratica voglio
  poter premere un bottone ed eliminare un progetto scelto.

Scenario: Delating a project
  
  Given There is a project called "TextMate 2" 
  And I am on the homepage
  And I follow "TextMate 2"
  When I follow "Delete Project"
  Then I should see "Project has been deleted."
  And I should not see "TextMate 2"
  
   
