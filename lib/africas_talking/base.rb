class AfricasTalking::Base

	BASE_URI='https://api.africastalking.com'

  URLS={
    sms_url: '/version1/messaging',
    subscription_url: '/version1/subscription',
    userdata_url: '/version1/user',
    airtime_url: '/version1/airtime',
    voice_url: 'https://voice.africastalking.com'
  }

	def post(url, body=nil)
		Typhoeus.post("#{BASE_URI}#{url}", body: body, headers: headers)
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
    parsed_response.collect { |msg| AfricasTalking::SMSMessage.new(
                               msg["id"], msg["text"], msg["from"] , msg["to"], msg["linkId"], msg["date"])}
  end

  def parse_api_response(response)
    JSON.parse(response.body)
  end

  def api_error_messages(response)
  	AfricasTalking::AfricasTalkingGatewayError, parse_api_response(response)["SMSMessageData"]["Message"]
  end

  def headers
    {'Accept' => "application/json", 'apiKey'=> ENV['africas_talking_apikey']}
  end

end