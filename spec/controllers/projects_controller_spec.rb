=begin
         'spec_helper.rb'   viene caricato da /spec. Ha il compito di caricare l'ambiente per i test. 
          Ha già il codice necessario per includere l'ambiente Rails e anche gli helper associati a Rails. 
          Inoltre carica tutto quello che in contra  in spec/support e nelle sue sottodirectory. 
          
          describe : ci serve a descrivere un componente, in questo caso la classe ProjectsController.
                     Racchiude un insieme di tests, detti esempi che ci servono a testare un comportamento
                     del modulo.       
          
          get  : Dice a RSpec di eseguire l'azione show(), ovvero di eseguire una HTTP GET request 
                 all'azione show del controller ProjectsController      
                 L'oggetto response modella la risposta a questa get, e testiamo che sia una redirect 
                 verso /projects. Analogamente post(), put(), delete() sono i corrispettivi metodi 
                 http.  
                 
          _______________________
          
          Restricting Action to admins only 
          
          
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
         
         _______________________
         
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
       
      #_________________________________________________________________________
        
        @instance_user = Factory(:user, :email=>"domenico@lives.it",
                                        :password=>"cravatta",
                                        :password_confirmation=>"cravatta") 
        
        p "INSIDE describe() DEBUGGING self : #{self} "
        p "INSIDE describe() DEBUGGING self.class : #{self.class} "
        p "INSIDE describe() DEBUGGING @instance_user : #{@instance_user} "
      
      #________________________________________________________________________
         
      
        let(:user) do
           create_user! 
        end
       
        let(:project) do
         project = Factory(:project)
        end
       
       
       context " standard (signed in ) users " do
      
      #_____________________________________________________________________
      
       @instance_user = Factory(:user, :email=>"domenicopeg@livesgo.it",
                                        :password=>"cravatta",
                                        :password_confirmation=>"cravatta") 
       
      
      
        p "INSIDE context() DEBUGGING self : #{self} "
        p "INSIDE context() DEBUGGING self.class : #{self.class} "
        p "INSIDE context() DEBUGGING @instance_user : #{@instance_user} "
          
      #_________________________________________________________________________   
        
       
         before(:each) do
           
           @instance_user = Factory(:user, :email=>"dome@livesgooo.it",
                                        :password=>"cravatta",
                                        :password_confirmation=>"cravatta") 
       
         end 
          
          it "displays an error for a missing project" do
               
               p "INSIDE it() DEBUGGING self : #{self} "
               p "INSIDE it() DEBUGGING self.class : #{self.class} "
               p "INSIDE it() DEBUGGING @instance_user : #{@instance_user} "

=begin
         Dagli output esaminati, si vede che RSpec con describe(), context(), it() crea diverce istanze di Class e quindi 
         gli ambienti sono diversi. In particolare stai attento alle variabile d'istanza. 
         
         Per questo motivo se desideri condividere dentro it() una certa istanza di User devi utilizzare: 
         
         before(:each)
         
         before(:all)
          
         In particolare si noti che: 
         
          before(:each) do
           
             @instance_user = Factory(:user, :email=>"dome@livesgooo.it",
                                        :password=>"cravatta",
                                        :password_confirmation=>"cravatta") 
       
           end  
         
          che viene eseguito per ogni it() non da problemi di duplicazione della email, come se al 
          passaggio da una it e l'altra l'utente creato venga eliminato dal database di test. 

=end
               
               sign_in(:user,user)      
               get :show, :id=>"not-here"
               response.should redirect_to(projects_path)
               message="The project you were loocking for could not be found."
               flash[:alert].should eql(message) 
            end
             
            it "cannot access the new,create,edit,update,destroy actions" do
               
               p "INSIDE it(..) DEBUGGING self : #{self} "
               p "INSIDE it(..) DEBUGGING self.class : #{self.class} "
               p "INSIDE it(..) DEBUGGING @instance_user : #{@instance_user} "
               
                  sign_in(:user,user) 
                  {
                  :new=>"get",
                  :create=>"post",
                  :edit=>"get",
                  :update=>"put",
                  :destroy=>"delete"
                 }.each do |action,http_method|
                        
                        send(http_method,action,:id=>project.id) # send viene utilizzato così: send(nome_metodo,argomenti) 
                        response.should redirect_to root_path
                        flash[:alert].should eql("You must be an admin to do that.")
                 end 
              
             end
       
           it "cannot access the show action" do
               sign_in(:user,user) 
               get :show,:id=>project.id
               response.should redirect_to projects_path 
               flash[:alert].should eql("The project you were loocking for could not be found.") 
          end   
         
       
       end
       
end
