=begin
       Paypal.
        
       The PayPal Sandbox is a self-contained environment within wich you can prototype and test PayPal
       feature and APIs. 
        
       Test Account:  test01_1324998545_biz@live.it Dec 27, 2011 07:09:30 PST
       API Username: test01_1324998545_biz_api1.live.it
       API Password: 1324998570
       Signature:   AoIQgHY44Q-MLFl8moVLIwrlxyetAYDMQWA7aTU08l1JqvbX0lABMP.C 

       Ci sono diverse cose da notare. In primis diciamo che in indez.html.erb abbiamo 
       generato un link, con il metodo link_to ma invece di generarlo sfruttando le risorse,
       lo abbiamo generato in questo modo passando l'opzione :action=>
       
         :action => 'checkout'
       
       che genera: 
       
         GET http://127.0.0.1:3000/payments/checkout 
       
       quindi poichè index.html.erb è associata all'azione index del controllore payments, l'helper sa 
       che :action=>checkout si riferisce al controllore payments. In routes.rb ci limitiamo a inserire
       
        get /payments/checkout ( che per default si riferisce all'azione payments#checkout )
       
      


       1) Come primo step, generiamo da paypal il pulsante adeguato alle nostre esigenze. 
       2) Come secondo step costruiamo il metodo gateway con le credenziali fornite. 
       3) Come terzo step costruiamo il metodo   
         
=end

class PaymentsController < ApplicationController
  
  include ActiveMerchant::Billing
 
  
  def index
  end

  def confirm
  end

  def complete
  end

  def checkout
     
     setup_response = gateway.setup_purchase(5000,
     
      :ip=>request.remote_ip,
      
      :return_url=>url_for(:action=>'confirm',:only_path=>false),
      
      :cancel_return_url=>url_for(:action=>'index', :only_path=>false)
     )    
     
     redirect_to gateway.redirect_url_for(setup_response.token)
     
  end


  private 
   
  def gateway
     
     @gateway ||=PaypalExpressGateway.new(
     
        :login=>"test01_1324998545_biz_api1.live.it",
        :password=>"1324998570",
        :signature=>"AoIQgHY44Q-MLFl8moVLIwrlxyetAYDMQWA7aTU08l1JqvbX0lABMP.C"             
     )     
  end

 


end
