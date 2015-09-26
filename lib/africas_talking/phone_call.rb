class AfricasTalking::PhoneCall < AfricasTalking::Base
	
	VOICE_URL = 'https://voice.africastalking.com'	


	##########CALL
	#######POST
	#####PARAMS#########
	####---------------##
	###1.from
	###2.to
	###
	def call(from, to)
		call_json = {username: username, from: from, to: to}
		response = post(%{#{VOICE_URL}/call}, call_json)
		response_object = JSON.parse(response, quirky_mode: true)

		#######Handle Errors
	end
	alias_method :make_call, :call


	#########FETCH QUEUED CALLS
	######POST
	######PARAMS###############
	###------------------------
	###1. Phone Number
	###2. Queue Name
	###
	def fetch_queued_calls(phone_number, queue_name)
		calls_json = {username: username, phoneNumbers: phone_number, queueName: queue_name}
		response = post(%{#{VOICE_URL}/queueStatus}, calls_json)
		response_object = JSON.parse(response, quirky_mode: true)

		return response_object['NumQueued'] if response_object['Status'].eql?("Success")
		raise AfricasTalkingGatewayException, response_object['ErrorMessage']
	end
	alias_method :queued_calls, :fetch_queued_calls


	##########UPLOAD MEDIA FILE
	########POST
	##########PARAMS###########
	######---------------------
	######1. URL
	######
	def upload_media_file(url)
		response = post(%{#{VOICE_URL}/mediaUpload}, {username: username, url: url})
		response_object = JSON.parse(response, quirky_mode: true)

		return response_object if if response_object['Status'].eql?("Success")
		raise AfricasTalkingGatewayException, response_object['ErrorMessage'] if !response_object['Status'].eql?("Success")
	end

	def compose_text_message(text_message)
		# xml_text = {response: {say: %{#{text_message}}}}
		# %{<?xml version="1.0" encoding="UTF-8"?>#{Gyoku.xml(text_message_json, {key_converter: :camelcase})}}
	end
	
end