class AfricasTalking::Subscription < AfricasTalking::Base
	
	def create(phone_number, short_code, keyword)
		validate_attributes_presence(%w(phone_number short_code, keyword))
		post('/subscription/create', subscription_body(phone_number, short_code, keyword))
	end

	def delete(phone_number, short_code, keyword)
		validate_attributes_presence(%w(phone_number short_code, keyword))
		post('/subscription/delete', subscription_body(phone_number, short_code, keyword))
	end

	def fetch(short_code, keyword, last_received_id=0)
		validate_attributes_presence(%w(short_code, keyword))
		url = %{/subscription?username=#{username}&shortCode=#{short_code_}&keyword=#{keyword_}&lastReceivedId=#{last_received_id_}}
		response = get(url)

		subscriptions = JSON.parse(response)['responses'].collect{ |subscriber|
			PremiumSubscriptionNumbers.new subscriber['phoneNumber'], subscriber['id']
		}

		# 	return subscriptions
		# else
		# 	raise AfricasTalkingGatewayException, response
		# end
	end


private

	def validate_attributes_presence(*attrs)
		attrs.each do |attribute| 
			raise AfricasTalkingGatewayException, "#{attribute} can not be blank!" if attribute.blank?
		end
	end

	def subscription_body(phone_number, short_code, keyword)
		{
			username: username, phoneNumber: phone_number, shortCode: short_code, keyword: keyword
		}
	end

end