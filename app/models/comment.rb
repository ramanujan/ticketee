class Comment < ActiveRecord::Base
  after_create :set_ticket_state
  belongs_to :user
  belongs_to :ticket
  belongs_to :state
  validates :text, :presence=>true   
  
  private
  
  def set_ticket_state
  
    self.ticket.state = state 
    self.ticket.save!
  end

end
