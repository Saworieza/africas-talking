class AfricasTalking::Message < AfricasTalking::Base
	
	#POST
	#/version1/messaging
	#More documentation to come here
  def deliver!(recipients, message)
    body = {username: ENV['africas_talking_username'], message: message, to: recipients}
    response = post('/version1/messaging', body: body)
    
    return parse_api_response(response) if response.options[:response_code] == 200
    return parse_api_errors(response) if response.options[:response_code] == 201
    raise api_error_messages(response)
  end

  #POST
  #/?username=#{@user_name}&lastReceivedId=#{last_received_id}
  #More documentation to come here
  def fetch_messages(last_received_id)
  	response = post("?username=#{ENV['africas_talking_username']}&lastReceivedId=#{last_received_id}")

  	return build_messages_array(response) if response.options[:response_code] == 200
  	raise api_error_messages(response)
  end

end