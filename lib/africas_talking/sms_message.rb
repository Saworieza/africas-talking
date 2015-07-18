class AfricasTalking::SmsMessage
	
	attr_accessor :id, :text, :from, :to, :linkId, :date

  def initialize(id, text, from, to, linkId, date)
    @id = id
    @text = text
    @from = from
    @to = to
    @linkId = linkId
    @date = date
  end
	
end