class Api::V1::ProjectsController < Api::V1::BaseController
  
  def index
  
    respond_with( Project.for(current_user).all )
  
  end
  
end

# Poichè ProjectsController eredita da Api::V1::BaseController, allora questo controllore
# è pronto a rispondere a richieste di rappresentazioni JSON. Infatti respond_with(Project.all)
# andiamo senz'altro a restituire una rappresentazione JSON di una lista di tutti i progetti.
# Quello che fa respond_with è di invocare il metodo to_json sull'oggetto. Rails sa che deve
# ritornare una rappresentazione JSON quando gli arriva una richiesta nella forma 
# api/v1/projects.json che una delle forma con cui si può negoziare una rappresentazione.

