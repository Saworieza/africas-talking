class AfricasTalking::Reports::AirtimeResult
	
	attr_accessor :amount, :phone_number, :request_id, :status, :error_message, :discount

	def initialize(status, number, amount, request_id, error_message, discount)
		@status = status
		@amount = amount
		@discount = discount
		@phone_number = number
		@request_id = request_id	
		@error_message = error_message
	end
end