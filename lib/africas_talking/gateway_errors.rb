class AfricasTalking::GatewayErrors

	attr_accessor :error

	def initialize(error)
	  @error = error
	end
end