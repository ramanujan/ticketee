=begin
         'spec_helper.rb'   viene caricato da /spec. Ha il compito di CARICARE L'AMBIENTE PER IL TEST.
          Ha già il codice necessario per includere l'ambiente Rails e anche gli helpers associati a Rails. 
          Inoltre carica tutto quello che incontra  in spec/support e nelle sue sottodirectory. 
          
          describe : ci serve a descrivere un componente, in questo caso la classe ProjectsController.
                     Racchiude un insieme di tests, detti esempi che ci servono a testare un comportamento
                     del modulo ( in questo caso della classe ProjectsController ).       
          
          get      : Dice a RSpec di eseguire l'azione show() del controller da dove viene invocato, ovvero 
                     di eseguire una HTTP GET request all'azione show() del controller ProjectsController      
                     L'oggetto response modella la risposta a questa get, e testiamo che sia una redirect 
                     verso /projects. Analogamente post(), put(), delete() sono i corrispettivi metodi 
                     http.  
                 
          _________________________________________________________________________________________________
          
          --- Restricting Action to admins only --- 
          
          
          Per quanto riguarda la risorsa Project, desideriamo che tutte le azioni :new,:create,:edit,
          :update, :destroy siano accessibili solo da un utente amministratore. Qualche volta, è necessario
          eseguire del codice prima oppure dopo ogni esempio (it ""). Questo lo possiamo fare con i metodi
          RSpec before(), after() che indicano l'ambito in cui eseguire il blocco di codice. 
          
          Ad esempio: 
          
            before(:each) do 
               .. 
          
            end 
           
         Viene eseguito prima di ogni esempio, mentre
         
            before(:all) do
                ..
            end       
         
         Viene eseguito una volta sola prima dell'esecuzione del primo esempio. In questo test utilizzeremo
         anche il metodo RSpec let(). Il metodo let() viene utilizzato per creare un memoized helper. In
         altri termini, viene utilizzato per costruire un metodo che ritorna un valore, e che non verrà 
         eseguito prima di ogni esempio, ma solo quando invocato. 
         
         Qui sotto utilizziamo anche un blocco context. Viene utilizzato per specificare il contesto
         cioè la precondizione di un esempio, un ambiente preesistente. 
         
         ______________________________________________________________________________________________
         
         sign_in()
         
         Il metodo sign_in() è un helper di Devise. Come abbiamo detto sopra, l'eseguibile spec
         esegue come prima cosa spec_helper.rb. Qui dentro troviamo due blocchi di codice 
         molto importanti:
         
         Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
         
         RSpec.configure do |config| 
         ..
         end
          
         Il primo carica ed esegue con require tutti i file .rb dentro spec/support. 
         Il secondo è un metodo di classe che serve per impostare RSpec. In questo blocco
         possiamo inserire i nostri moduli,in modo da eseguire il mixing-in di questi 
         dentro la classe RSpec.  Ancora meglio è creare in support/ il file devise.rb e 
         inserire ivi :
         
            RSpec.configure do |config| 
          
              config.include Devise::TestHelpers 
          
            end 
         
         Perchè in codesto modo non dobbiamo rilanciare i generatori di Rspec per aggiornare 
         spec/spec_helper.rb quando aggiorniamo RSpec. 
         
         In effetti comincio a pensare che tutto il contesto esecutivo, istanzi una classe RSpec
         ed esegua un main() method che andrà a caricare i nostri test. Si noti che in realtà, 
         abbiamo inserito un filtro a include:
         
          RSpec.configure do |config| 
          
           config.include Devise::TestHelpers, :type=>:controller  
          
          end 
         
         In questo modo l'inclusione è limitata solo ai test per i controllers.
       
       
         OSSERVAZIONE: Al fine di essere DRY, abbiamo cambiato 
            
            let(:user) do
          
              user = Factory(:user)
          
              user.confirm!
         
              user
            end
          
        con let(:user) do
                
                create_user!
                
            end  

        dove create_user! è un helper situato in support dentro seed_helepers.rb.

=end

require 'spec_helper'

describe ProjectsController do
       
        let(:user) do
           create_user! 
        end
       
        let(:project) do
         project = Factory(:project)
        end
       
       
       context "not signed in users" do
       
               it "cannot access any actions before login " do
                    get :index 
                    response.should redirect_to "/users/sign_in"
          
                   { 
                    :new=>"get",
                    :create=>"post",
                    :edit=>"get",
                    :update=>"put",
                    :show=>"get",
                    :destroy=>"delete"
                   }.each do |action,http_method| 
                   
                      send(http_method,action,:id=>project.id) 
                      response.should redirect_to "/users/sign_in"           
                   end  
         
              end
       
      end
       
       
      context " standard (signed in ) users " do
       
         before(:each) do
            
             sign_in(:user,user)
         
         end
          
          it "displays an error for a missing project" do    
               
               get :show, :id=>"not-here"
               response.should redirect_to(projects_path)
               message="The project you were looking for could not be found."
               flash[:alert].should eql(message) 
            end
          
          it "cannot access the show action" do
            
               get :show, :id=>project.id
               response.should redirect_to(projects_path)
               message="The project you were looking for could not be found."
               flash[:alert].should eql(message) 
            
          end
          
           it "cannot access any of these actions " do
                
               { 
                    :new=>"get",
                    :create=>"post",
                    :edit=>"get",
                    :update=>"put",
                    :destroy=>"delete"
                   }.each do |action,http_method| 
                   
                      send(http_method,action,:id=>project.id) 
                      response.should redirect_to root_path           
                   end  
                
                
           end
             
    end


end   

