=begin
      Il metodo devise viene dalla libreria gem devise. Configura il gem per fornire specifiche funzioni
      a questa risorsa.  In pratica include i moduli elencati. 
      
      :database_authenticable => Aggiunge l'abilità di autenticare un utente tramite l'inserimento
                                 di una email e password.  
                                 
      :registrable => Fornisce le funzionalità affinchè l'utente possa registrarsi.
      
      :recoverable => Fornisce le funzionalità affinchè l'utente possa recuperare la password
                      nel caso l'avesse smarrita. 
      
      :rememberable => Fornisce una check box per gli utenti che desiderano che la loro sessione
                       venga ricordata. Se questi utenti chiudono il browser e quindi in un secondo
                       tempo lo riaprono e rivisitano l'applicazione saranno automaticamente autorizzato
                       al loro ritorno. 
                       
     :trackable => Aggiunge funzionalità per tracciare un utente. Quante volte ha eseguito sign-in,
                   quale è l'ultima volta che si è fatto vivo, IP corrente e l'ultimo IP utilizzato
                   ecc..
                   
     :validateable => Validazione affinchè l'utente inserisca dei dati corretti come una email
                     ben formattata e la password.                                  
                       
     Devise fornisce anche altri moduli opzionali:
     
     :token_authenticable => Lascia che gli utenti si autentichino via token. Può essere
                             utilizzato insieme con :database_authenticable
     
     :encryptable =>  Aggiunge supporto ad altri metodi per cripatre la password.
                      Per default utilizza bcrypt.
     
     :confirmable => Quando un utente si registra nella nostra applicazione, viene spedita
                     una bella mail che al suo interno possiede un bel link che l'utente deve 
                     cliccare per confermare la registrazione. Ci serve chiaramente a prevenire
                     sign up automatici. 
    
     :lockable => Tiene fuori un utente per uno specifico ammontare di tempo, se egli fallisce 
                  un certo numero di autenticazioni. Sia lo slot temporale che il numero di ripetizioni
                  sono configurabili. Di default sono 1h dopo 20 ripetizioni. 
                  
     :timeoutable => Se l'utente non esegue alcuna attività nella sua propria sessione, allora
                     quando passa un certo periodo di tempo, egli viene automaticamente signed-out.
                     Questo è molto utile, per tutti quei siti che possono essere utilizzati da utenti
                     multipli nello stesso computer, come email o banking site.                                                    
     
     :ominauthable => Aggiunge il supporto per OmniAuth gem che permette un modo alternativo di 
                      identificarsi utilizzando web services come OAuth e OpenID.                        
     ______________________________
     
     attr_accessible() Ci serve per prevenire il mass-assignmement attack. In pratica metodi quali 
     create() oppure update_attributes() ricevono come parametri un hash contentente TUTTI GLI ATTRIBUTI
     fisici cioè presenti nel database. Un utente potrebbe provare ad ackerare la form per impostare 
     un attributo che non dovrebbe essere impostato dalla form, come ad esempio un attributo boolean 
     di un campo admin. 
     
     Utilizzando attr_accessible() possiamo indicare esplicitamente quali attributi andrebbero impostati
     dall'utente.  
                       
     ___________
     
     Nel nostro esempio abbiamo attivato il modulo :confirmable. In pratica quando un utente esegue per la
     prima volta la registrazione, devise si occuperà di generare un confirmation_token. Una email con un
     link contenente questo token viene spedito all'utente, e confirmation_sent_at viene impostato. 
     Quando poi l'utente clicca il link, il suo account verrà confermato, e confirmed_at verrà impostato
     al current time nel processo.
     
     1) Generazione del token.
     2) Spedizione token via email e impostazione confirmation_sent. 
     3) Utente clicca e conferma. 
     4) Impostazione confirmed_at alla data corrente.                    
      
     Autenticazione e Autorizzazione.
     
     Con il termine autenticazione, si indica l'insieme di funzionalità implementate dalla nostra
     applicazione per riconoscere un utente. 
     
     Con il termine autorizzazione, si indica l'insieme di funzionalità implementate dalla nostra
     applicazione, utilizzato per riconoscere i privilegi di un utente autenticato, e cioè un determinato
     utente, cosa può fare e cosa non può fare. 
      
      
                       
=end

class User < ActiveRecord::Base
   
  has_many :tickets
   
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
