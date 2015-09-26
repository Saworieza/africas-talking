class AfricasTalking::Message < AfricasTalking::Base

  def fetch_messages(last_received_id=0)
    get("/version1/messaging?username=#{username}&lastReceivedId=#{last_received_id}")
  end

  def deliver(recipients, message)
    post(
      %{/version1/messaging}, {
      username: username, 
      message: message, 
      to: prepare_recipients(recipients)})
  end

  def deliver_with_shortcode(recipients, message, sender)
    post(
      %{/version1/messaging}, {
      from: sender,
      message: message, 
      username: username,
      to: prepare_recipients(opts.fetch(:recipients))})
  end

  def enqueue_messages(opts)
    post(
      %{/version1/messaging}, {
      message: opts.fetch(:message, ""), 
      sender: opts.fetch(:sender, nil),
      enqueue: opts.fetch(:enqueue,1), 
      bulkSMSMode: opts.fetch(:bulkSMSMode, 1),
      to: prepare_recipients(opts.fetch(:recipients))})
  end


  def deliver_premium_messages(opts)
    post(
      %{/version1/messaging}, {
      message: opts.fetch(:message, ''),
      enqueue: opts.fetch(:enqueue, 0),
      linkId: opts.fetch(:linkId, nil),
      keyword: opts.fetch(:keyword, nil),
      to: prepare_recipients(opts.fetch(:recipients)), 
      retryDurationInHours: opts.fetch(:retryDurationInHours, 1)})
  end

private

  def prepare_recipients(recipients)
    rcpts = Array.new
    recipients.split(',').each { |r| rcpts << r.strip.gsub(/^0/,'+254') }
    rcpts.join(', ')
  end

end