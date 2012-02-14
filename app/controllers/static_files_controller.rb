# In questo controller, il metodo show() ci serve per accedere al file. 
# In altri termini significa fornire, distribuire il file a chi vi accede.
# In questo controller utilizziamo il metodo send_file() di ActionController::Streaming
# per spedire il file al client. 

#   send_file(:path_name_file_da_spedire,:options ) nelle opzioni possiamo

# inserire il nome del file, e il Content-Type. In questo modo il browser saprà 
# il nome del file e il suo MIME. 

class StaticFilesController < ApplicationController
   
  before_filter :authenticate_user! # Fornito da Devise, vede se l'utente ha fatto login 
  
  before_filter :find_asset, :only=>[:show]
  
  def find_asset 
    begin
      @asset = Asset.find(params[:id])  
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The asset you were looking for could not be found." 
      redirect_to root_path 
    end 
  
  end
  
 
 
  def authorized? 
     
     unless current_user.admin?  
       return (true ? can?(:view,@asset.ticket.project) : false) 
     
     end
     
     true
 
 end
  
 private :authorized?, :find_asset
 
 
  def show
    
    # L'idea è quella di fornire i file con show(), ma di controllare prima se si hanno i permessi necessari.
    # Abbiamo deciso che chi ha il permesso di accedere in lettura ad un progetto, allora può accedere anche
    # ai file allegati al ticket.    
      
   
     if authorized?
          send_file @asset.asset.path,
                    :filename     => @asset.asset_file_name,
                    :content_type => @asset.asset_content_type  
       else
          flash[:alert]="The asset you were looking for could not be found." 
          redirect_to root_path
       end           
  end

  def new

# Poichè l'oggetto di tipo Ticket per la form, è solo un nuovo record, non è tanto importante sapere
# precisamente cosa sia l'oggetto e ne se provenga dall'azione new() di TicketsController e ne se provenga
# invece dall'azione new qui sotto. Tutte le istanze di Ticket sono le stesse finchè non vengono
# salvate nel database e gli venga assegnato un identificatore univoco. In pratica una nuova istanza 
# transient ci serve per fields_for(). 
    
    @ticket=Ticket.new 
    
    @ticket.assets.build  
    
    number = params[:number].to_i
    
    render :partial=>"static_files/file_fields",
           :locals =>{:number=>number}
  
  end



end
