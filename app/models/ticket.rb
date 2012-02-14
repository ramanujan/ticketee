# Ricordiamo che invocare accepts_nested_attributes_for :assets  
# crea un metodo d'istanza noto come assets_attributes= che può ricevere un array di hash, oppure un hash di hash contenente i valori 
# per istanziare i veri oggetti Asset della collezione desiderati. In pratica all'azione create del controller Ticket arriva: 
#         
#          params = {"utf8"=>"✓", 
#                    "authenticity_token"=>"PnoRxQq5634WnBjL4FDN6PkKrglEArDFHy/xuWp4C6U=", 
#                    "ticket"=>{"title"=>"...",
#                               "description"=>"...",
#                               "assets_attributes"=>{"0"=>{"asset"=>"client_file_name1"}, 
#                                                     "1"=>{"asset"=>"client_file_name2"}, 
#                                                     "2"=>{"asset"=>"client_file_name3"}
#                                                     }
#                          }, 
#               
#                "commit"=>"Create Ticket"
#                }
#          
#        quindi in create possiamo fare: 
#        
#        @ticket = @project.tickets.build(params[:ticket].merge!(:user=>current_user))
#        
# Ricordiamo che assets_attributes => {"0"=>{"asset"=>"client_file_name"}} per fare un esempio,
# punta la file temporaneo uploadato. Per via di nested_attributes   
# 
#  @project.tickets.build(params[:ticket].merge!(:user=>current_user))
#
# ha l'effetto istanziare (initialize) i tre oggetti asset incluso 0=>. Questo attiva paperclip. 
#
#
#
#
#
#



class Ticket < ActiveRecord::Base

 belongs_to :project
 belongs_to :user
 validates  :title, :presence=>true, :length=>{:maximum=>30} 
 validates  :description, :presence=>true, :length=>{:minimum=>8}
 
 has_many   :assets
 accepts_nested_attributes_for :assets
 
 
 
end