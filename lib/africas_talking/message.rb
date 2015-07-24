class AfricasTalking::Message < AfricasTalking::Base

	#POST
	#/version1/messaging
  #----------------------------------------------------------------------------
  # Specify the numbers that you want to send to in a comma-separated list
  # to      = "+254711XXXYYY,+254733YYYZZZ";
  # message = And of course we want our recipients to know what we really do

  def deliver(recipients, message)
    post('/version1/messaging', {username: username, message: message, to: prepare_recipients(recipients)})
  end

  #POST
  #/version1/messaging#deliver_with_shortcode
  #----------------------------------------------------------------------------
  #
  # Specify your AfricasTalking shortCode or sender id
  # sender = "shortCode or senderId"

  def deliver_with_shortcode(recipients, message, sender)
    post('/version1/messaging', {username: username, message: message, to: prepare_recipients(opts.fetch(:recipients)), from: sender})
  end

  #POST
  #/version1/messaging#enqueue_messages
  #----------------------------------------------------------------------------
  #
  # sender = nil #
  # bulkSMSMode   # This should always be 1 for bulk messages
  # # enqueue flag is used to queue messages incase you are sending a high volume.
  # # The default value is 0.
  # opts={enqueue: 1, bulkSMSMode: 1, sender: "shortCode/senderId"}
  # gateway = AfricasTalkingGateway.new(username, apikey)
  # reports = gateway.sendMessage(to, message, sender, bulkSMSMode, enqueue)

  def enqueue_messages(opts)
    post('/version1/messaging', {
      to: prepare_recipients(opts.fetch(:recipients)), message: opts.fetch(:message, ""), sender: opts.fetch(:sender, nil),
      enqueue: opts.fetch(:enqueue,1), bulkSMSMode: opts.fetch(:bulkSMSMode, 1)})
  end

  #POST
  #/version1/messaging#premium_messages
  #----------------------------------------------------------------------------
  #
  #########Required fields to deliver a premium message through the API########
  #############################################################################
  # To send a premium message, build a HASH (as shown below) with the following attributes keeping in mind the defaults.
  # 1.Specify your premium shortCode and keyword
  # 2.Set keyword as None where not used (Mostly for onDemand services)
  # 3.Set the bulkSMSMode flag to 0 so that the subscriber gets charged
  # 4.Set the enqueue flag to 0 so that your message will not be queued or to 1 for many messages
  # 5.Incase of an onDemand service, specify the link id. else set it to nil
  # 6.linkId is received from the message sent by subscriber to your onDemand service
  # 7.Specify retryDurationInHours: The numbers of hours our API should retry to send the message incase it doesn't go through.
  # opts={recipients: "0710XXTYYY", message: "Hey there testing something awesome", bulkSMSMode: 0, shortCode:"XXXXX", enqueue: 0, keyword: nil, linkId: "messageLinkId"}

  def deliver_premium_messages(opts)
    post('/version1/messaging', {
        to: prepare_recipients(opts.fetch(:recipients)), message: opts.fetch(:message),
        keyword: opts.fetch(:keyword, nil), enqueue: opts.fetch(:enqueue, 0),
        linkId: opts.fetch(:linkId, nil), retryDurationInHours: opts.fetch(:retryDurationInHours, 1)})
  end

  #GET
  #/?username=#{username}&lastReceivedId=#{last_received_id}
  # The gateway will return 10 messages at a time back to you, starting with
  # what you currently believe is the lastReceivedId. Specify 0 for the first
  # time you access the gateway, and the ID of the last message we sent you
  # on subsequent results

  def fetch_messages(last_received_id=0)
  	get("/version1/messaging?username=#{username}&lastReceivedId=#{last_received_id}")
  end

end