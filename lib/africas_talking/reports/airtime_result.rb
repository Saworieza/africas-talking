class AfricasTalking::Reports::AirtimeResult
	
	attr_accessor :amount, :phone_number, :request_id, :status, :error_message, :discount

	def initialize(response)
		@status = response.fetch(:status)
		@amount = response.fetch(:amount)
		@discount = response.fetch(:discount)
		@phone_number = response.fetch(:number)
		@request_id = response.fetch(:request_id	)
		@error_message = response.fetch(:error_message)
	end
end