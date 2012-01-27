Factory.define :user do |user|
  
  user.sequence(:email){ |n| "user#{n}@ticketee.com"} 
  
  user.password "password"
  
  user.password_confirmation "password"
  
 
   
end

=begin
          Il metodo sequence() è aggiunto da Factory Girl. Questo metodo genera un numero univoco 
          progressivo, una sequenza in effetti, e lo passa ad un blocco eseguito per generare un
          valore per l'attributo email.   
=end