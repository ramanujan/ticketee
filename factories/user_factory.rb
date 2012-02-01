=begin 
       --Factory Girl--
       
       FactoryGirl è utilizzato come rimpiazzo delle fixture. In pratica ci serve per simulare un oggetto
       del nostro MODEL. In pratica possiamo simulare situazioni come, istanza salvata nel database,
       istanza non ancora salvata,ecc...
       
       Definiamo un oggetto factory con il metodo Factory.define() a cui dobbiamo passare il nome 
       della classe del model ( :user in questo caso) e un blocco di codice dove inseriamo il codice
       necessario per creare un oggetto del model di default. Qui sotto ad esempio abbiamo definito 
       3 attributi.   
       
       Dopo aver definito una User factory, possiamo modificare i nostri tests per utilizzare i 
       factory objects. Invece di creare user objects nei tesst con User.create! utilizzeremo Factory.
       
       Ad esempio possiamo utilizzare:
       
       it "... " do
          user=Factory.create!(:user, :username => "frank", :password => "secret", :password_confirmation=>"password")
          .. 
       end
       
       
       oppure semplicemente: 
           
           it ".." do  
              user=Factory(:user, :username => "frank", :password => "secret", :password_confirmation=>"password")   
              ..
          end
               
       Per creare e propagare nel database di test un'istanza del MODEL User. Si noti che se non specifichiamo un hash di attributi, 
       verrà generato il model di default, cioè quello specificato nel blocco. 
       
       
       --Creazione di sequenza con Factory Girl -- 
       
       Le nostra classi del model, come pure User, possiedono sempre un certo numero di validazioni, e FactoryGirl le gestisce bene
       tutte tranne una:
       
        validates :uniqueness=>true   
       
       Infatti in questo caso la nostra classe del MODEL richiede una email univoca, in modo che non 
       sia possibile che i nostri tests creino più di un'istanza di User (di default o no ) con il medesimo
       valore nel campo email. FactoryGirl per ovviare a questa situazione fornisce il metodo sequence()
       alla classe del MODEL creata. A questo metodo viene passato un attributo e un blocco di codice che 
       verrà utilizzato per creare il valore con un numero di sequenza univoca. 
       
       
=end


# In questo nome FactoryGirl ipotizza che si voglia istanziare la classe del MODEL User. 

Factory.define :user do |user|
  
  user.sequence(:email){ |n| "user#{n}@ticketee.com"} 
  
  p "DEFINED USER : "
  user.password "password"
  
  user.password_confirmation "password"
  
 
end

=begin
          Il metodo sequence() è aggiunto da Factory Girl. Questo metodo genera un numero univoco 
          progressivo, una sequenza in effetti, e lo passa ad un blocco eseguito per generare un
          valore per l'attributo email.   
=end