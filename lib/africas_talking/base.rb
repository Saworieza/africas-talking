class AfricasTalking::Base

	BASE_URI='https://api.africastalking.com'

  def prepare_recipients(recipients)
    recipients_array = []
    recipients.split(',').each { |recip| recipients_array << recip.strip.gsub(/^0/,'254') }
    recipients_array.join(', ')
  end

	def post(url, json_body=nil)
		Typhoeus.post("#{BASE_URI}#{url}", body: json_body, headers: headers)
	end

	def get(url)
		Typhoeus.post("#{BASE_URI}#{url}", headers: headers)
	end

	def parse_api_errors(response)
    reports = parse_api_response(response)["SMSMessageData"]["Recipients"]
    reports.collect { |entry|
                       AfricasTalking::StatusReport.new(entry["number"], entry["status"], entry["cost"]) }
  end

  def build_messages_array(response)
  	parsed_response = parse_api_response(response)["SMSMessageData"]["Messages"]
    parsed_response.collect { |msg| AfricasTalking::SMSMessage.new(msg["id"], msg["text"], msg["from"] , msg["to"], msg["linkId"], msg["date"])}
  end

  def parse_api_response(response)
    JSON.parse(response.body)
  end

  def api_error_messages(response)
  	AfricasTalking::AfricasTalkingGatewayError#, parse_api_response(response)["SMSMessageData"]["Message"]
  end

  def headers
    {'Accept' => "application/json", 'apiKey'=> 'c6ec656ed9bceb689289ccaa6e38d7f6c1b0718a1237b4c13391d1efc1108bfb'}
  end

end