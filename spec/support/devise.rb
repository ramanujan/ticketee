 RSpec.configure do |config|
   
   config.include Devise::TestHelpers, :type=>:controller  # <==== AGGIUTO DA DOMENICO, per gli helper forniti da Devise
   
 end
 

