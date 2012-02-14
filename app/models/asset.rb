class Asset < ActiveRecord::Base
   
     has_attached_file :asset, 
                       :path=>(Rails.root+"static_files/:attachment/:id/:filename").to_s
     
     # Rails.root: /home/domenico/Aptana Studio 3 Workspace/ticketee
     
     belongs_to :ticket

end

# Una volta che sia stato uploadato un file, Rails prepara params[:ticket][:asset] in modo che si riferisca ad 
# un' istanza di una sottoclasse di IO. Fisicamente il file è salvato in /temp. Una volta installato 
# PaperClip, utilizzeremo principalmente has_attached_file(), da dentro una classe del MODEL che chiamiamo
# Asset e che rappresenta un file. 

# Ricordiamo ancora una volta l'effetto di PaperClip#has_attached_file(). Questo metodo genera nella classe 
# da dove è invocato 5 attributi fisici con i relativi accessors. Se ad esempio abbiamo chiamato 
# has_attached_file :asset dentro Asset, allora verranno generati: 

# 0) asset
# 1) asset_file_name
# 2) asset_file_size
# 3) asset_content_type
# 4) asset_updated_at 

# asset() ritorna un'istanza di PaperClip::Attachment che gestisce il file uploadato. Ricordiamo inizialmente
# il file è in /temp e quindi non è stato salvato. PaperClip rende questo processo naturale e integrato 
# con il meccanismo ActiveRecord::save(). L'attachment così diventa un normale attributo.
# Con attached_file :asset possiamo passare anche delle opzioni interessanti. Le più utilizzate sono:

# 1) :url ==> Si tratta del full URL da dove l'attachment sarà pubblicamente accessibile. Questo URL può 
#             riferirsi sia ad una directory servita direttamente via apache (mongrails o altro) sia 
#             sia ad un'azione di un nostro controllore, che ne analizzi le autorizzazioni e i permessi.
#             Possiamo specificare un FULL-DOMAIN-PATH, ma solitamente UN PATH ASSOLUTO è sufficiente. 
#             Il suo valore di default è 
#             
#                   "/system/:attachment/:id/:style/:filename"         
#
#             Dove attachment nel nostro caso è sostituito da 'assets'.Per noi non va bene, poichè 
#             questa questa è una cartella dentro public. Il file allegato al ticket non verrà salvato qui,
#             perchè non desideriamo che sia accessibile da tutti ma solo da chi ha i permessi di lettura
#             sul progetto. Esempi: 
#  
#             :url => "/:class/:attachment/:id/:style_:filename"
#             :url => "http://some.other.host/stuff/:class/:id_:extension"
# 
# 2) :path ==> Si tratta di specificare dove verrà salvato il file, una volta che sia stata
#              effettuata la propagazione del model Asset. In pratica quando verrà invocata 
#              ActiveRecord::save() per Asset. Nel nostro caso ciò avviene con il meccanismo di 
#              nested _attributes, e quindi con un assegnamento di massa. Nel nostro esempio 
#              desideriamo salvare il file e servirlo da una directory chiamata static_files
#              che creeremo nella root directory della nostra applicazione. In questo modo 
#              di cui desideriamo proteggere l'accesso sono posti fuori da publid directory. 
#    
# Quindi nel metodo show() del controller TicketsController, che ha il ruolo di mostrare una risorsa
# Ticket, prepareremo una view, che tra  le altre cose, mostrerà i file allegati. In effetti vi
# dovrà essere un link che avvierà l'attivazione del controller dei file StaticFilesController, e 
# in particolare dell'azione show() con cui serviremo l'asset. Quindi poichè in routes.rb abbiamo
# inserito 
#
#   resources : static_files allora: 
#                  
# static_files     GET    /static_files(.:format)                              {:action=>"index", :controller=>"static_files"}
#                  POST   /static_files(.:format)                              {:action=>"create", :controller=>"static_files"}
# new_static_file  GET    /static_files/new(.:format)                          {:action=>"new", :controller=>"static_files"}
# 
# edit_static_file GET    /static_files/:id/edit(.:format)                     {:action=>"edit", :controller=>"static_files"}
#
# static_file      GET    /static_files/:id(.:format)                          {:action=>"show", :controller=>"static_files"}
#                  PUT    /static_files/:id(.:format)                          {:action=>"update", :controller=>"static_files"}
#                  DELETE /static_files/:id(.:format)                          {:action=>"destroy", :controller=>"static_files"}
#
# 
# In particolare si noti che l'azione show: 
#
#
# static_file      GET    /static_files/:id(.:format)                          {:action=>"show", :controller=>"static_files"}
#
# 
#
#
#
#
#
#
#
#
#


  