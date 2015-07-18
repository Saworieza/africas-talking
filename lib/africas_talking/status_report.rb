class AfricasTalking::StatusReport
	
	attr_accessor :number, :status, :cost

  def initialize(number, status, cost)
  	@cost = cost
    @number = number
    @status = status
  end
	
end