class Link
  include Virtus.model
  include ActiveModel::Model
 
  attribute :longurl, String
  validates :longurl , presence: true
  
 
  def save
    if valid?
        persist!
        true
    else
        false
    end
  end

  private
   def persist!
        # shorten url 
        Shortener::ShortenedUrl.generate(self.longurl)
        
        #user = User.create!(email: email)
        #@expense = user.expenses.create!(amount: amount, paid: paid)
   end
    
end
