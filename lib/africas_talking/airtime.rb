class AfricasTalking::Airtime < AfricasTalking::Base

	#POST
	#http://api.africastalking.com/version1/airtime/send
	#There however is a limit of the amount you can send as shown below:
	#####Minimum Amount |	Maximum Amount
	#####KES 10 	      | KES 10,000
	###
	###Parameters
	###API Key: API key generated from your account settings: required(*)
	###Accept header: This is the format you would like your data formatted(xml/json) :	No	
	###Username: This is your Africa'sTalking username : required(*)
	###Recipients: Contains the a list of airtime recipients in JSON format. It should look like:
	###############[{"phoneNumber":"+254700XXXYYY","amount":"KES X"},{}], required(*)
	#[{mobile_number: 0710000009, airtime: 500},{mobile_number: 0710335602, airtime: 600}]
	
	def buy(recipients)
		 response = post_airtime('/version1/airtime/send', {username: username, recipients: prepare_json(recipients)})
		 parse_airtime_response(response)
	end
	alias_method :purchase, :buy
	alias_method :send_airtime, :buy

private

	def prepare_json(recipients)
		prepared_recipients_array = Array.new
		recipients.each do |recipient|
			prepared_recipients_array << {
				"phoneNumber" => format_mobile(recipient.fetch(:mobile_number, '0710')), 
				"amount" => recipient.fetch(:airtime, 0.0)
			}
		end
		prepared_recipients_array
	end

	def parse_airtime_response(response)		
		airtime_purchase_successful(response) if response.options[:response_code].eql?(200|201)
		AfricasTalking::GatewayErrors.new(response['errorMessage']) unless response.options[:response_code].eql?(200|201)
	end

	def airtime_purchase_successful(response)
		airtime_successful_results = Array.new
		responses = JSON.parse(response)['responses']			
		responses.each { |result| results << airtime_result(result)}
		airtime_successful_results
	end

	def airtime_result(result)
		AfricasTalking::Reports::AirtimeResult.new(
			result['status'], result['phoneNumber'], result['amount'], result['requestId'], 
			result['errorMessage'], result['discount']
		)
	end

end