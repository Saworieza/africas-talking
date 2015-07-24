class AfricasTalking::AfricasTalkingGatewayError < Exception

	attr_accessor :error

	def initialize(error)
	  @error = error
	end
end