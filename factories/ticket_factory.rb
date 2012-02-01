=begin
         Approfittiamo in questa sede di parlare della capacità di FactoryGirl di gestire le associazioni.
         FactoryGirl permette di definire un'associazione nella factory invocando il metodo:
         
         association()
         
         e passando come parametro il nome dell'associazione. Ad esempio
         
         Factory.define :ticket do |ticket|
         
               ticket.title "A ticket"         
               ..
               ticket.association :user
         
         end 
         
         Quando l'oggetto Ticket viene creato dalla factory, andrà a cercare una factory denominata
         User e automaticamente andrà a costruire l'oggetto associato. Se la tua associazione dovesse
         avere un nome differente, come ad esempio author, allora: 
         
           Factory.define :ticket do |ticket|
         
               ticket.title "A ticket"         
               ..
               ticket.association :author, :factory=>:user
          
         end 
        
        
        
         
=end

Factory.define :ticket do |t|
  
  t.title "A ticket."
  t.description "A ticket, nothing more."
  t.association :user
  t.association :project 
  
end


