class AfricasTalking::PhoneCall < AfricasTalking::Base
	
	VOICE_URL = 'https://voice.africastalking.com'	

	def call(from, to)
		body = { username: username, from: from, to: to }
		response = executePost("#{VOICE_URL}/call", body)

		# jObject = JSON.parse(response, :quirky_mode => true);
		# raise AfricasTalkingGatewayException, jObject['ErrorMessage'] if jObject['Status'] != "Success"
	end
	alias_method :make_call, :call

	
end