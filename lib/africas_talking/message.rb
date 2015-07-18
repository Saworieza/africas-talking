class AfricasTalking::Message < AfricasTalking::Base
	
	#POST
	#/version1/messaging
  ##Sending a message
  ##2. recipients: 'this are the numbers that you want to send, 
  ################if the recipients are more than one, use a comma to separate them eg: [0711XXXYYY,0733YYYZZZ]'
	##3. message: `This is the message you want to send to your recipients`
  ################send with sender_id or shortcode parameter#########
  #### build an opts hash and pass in sender option as follows: ``opts={sender: 'shortCode or senderId'}
  ###############enqueue messages######################################
  #####to enqueue a message, an enqueue flag is added to the opts: {} hash as shown: opts: {enqueue: 1} 
  ##############premium messages#######################################
  #####to send a premium message:
  ##1. Specify your premium shortCode and keyword --> shortCode="XXXXX"
  ##2. Set keyword as None where not used (Mostly for onDemand services) ---> keyword="premiumKeyword"
  ##3. Set the bulkSMSMode flag to 0 so that the subscriber gets charged --> bulkSMSMode=0
  ##4. Set the enqueue flag to 0 so that your message will not be queued or to 1 for many messages --> enqueue=0
  ##5. Incase of an onDemand service, specify the link id. else set it to nil
  #####linkId is received from the message sent by subscriber to your onDemand service --> linkId="messageLinkId"
  ##6. Specify retryDurationInHours: The numbers of hours our API should retry to send the message
  #####incase it doesn't go through. It is optional --> retryDurationInHours = "No of hours to retry"
  #####opts={sender: nil, bulk: 1, retry: nil, enqueue: 0, keyword: nil, linkId: nil}
  #####
  ####ENV['africas_talking_username']
  def deliver(recipients, message, opts={})
    symbolized_opts = opts.symbolize_keys!

    body = {
      username: 'username', 
      message: message, to: recipients, from: symbolized_opts.fetch(:sender, 'nil'),
      bulkSMSMode: symbolized_opts.fetch(:bulk, 1), enqueue: symbolized_opts.fetch(:enqueue, 0), 
      keyword: symbolized_opts.fetch(:keyword, 'nil'), linkId: symbolized_opts.fetch(:linkId), 
      retryDurationInHours: symbolized_opts.fetch(:retry_duration, 'nil')}

    response = post(AfricasTalking::Base::URLS.fetch(:sms_url), body: body)
    
    return parse_api_response(response) if response.options[:response_code] == 200
    return parse_api_errors(response) if response.options[:response_code] == 201
    raise api_error_messages(response)
  end

  #POST
  #/?username=#{ENV['africas_talking_username']}&lastReceivedId=#{last_received_id}
  # The gateway will return 10 messages at a time back to you, starting with
  # what you currently believe is the lastReceivedId. Specify 0 for the first
  # time you access the gateway, and the ID of the last message we sent you
  # on subsequent results
  def fetch_messages(last_received_id=0)
  	response = post("?username=username&lastReceivedId=#{last_received_id}")

  	return build_messages_array(response) if response.options[:response_code] == 200
  	raise api_error_messages(response)
  end

end