Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table

  @users=[]
  table.hashes.each do |attributes|
  # ATTENZIONE!!!! unconfirmed è String che contiene true/false (viene da un file di testo)
  unconfirmed = attributes.delete("unconfirmed") # Ricorda che delete() ritorna il valore
                                                 # dell'attributo e lo cancella dall'Hash. Ritorna nil se non viene trovata la chiave
      
       @user = User.create! attributes   
       
       @user.update_attribute(:admin,(attributes[:admin]=='true'))   
       
       if unconfirmed.nil? || unconfirmed=='false'
          
          @user.confirm! #Aggiorna anche il database. 
       end
       
       @users << @user
   

  end

end



