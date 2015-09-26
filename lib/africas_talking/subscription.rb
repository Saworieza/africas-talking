class AfricasTalking::Subscription < AfricasTalking::Base
	

	#####POST
	####/subscription/create
	######PARAMS#############
	#####----------------------
	###1. PhoneNumber
	###2. ShortCode
	###3. Keyword
	####
	def create(phone_number, short_code, keyword)
		validate_attributes(%w(phone_number short_code, keyword))
		post('/subscription/create', subscription_body(phone_number, short_code, keyword))
	end

	#####POST
	####/subscription/delete
	######PARAMS#############
	#####----------------------
	###1. PhoneNumber
	###2. ShortCode
	###3. Keyword
	####
	def delete(phone_number, short_code, keyword)
		validate_attributes(%w(phone_number short_code, keyword))
		post('/subscription/delete', subscription_body(phone_number, short_code, keyword))
	end

	#####GET
	####/subscription/create
	######PARAMS#############
	#####----------------------
	###1. Phone_number
	###2. ShortCode
	###3. last_received_id
	####	
	def fetch(short_code, keyword, last_received_id=0)
		validate_attributes(%w(short_code, keyword))

		url = %{/subscription?username=#{username}&shortCode=#{short_code}
						 &keyword=#{keyword}&lastReceivedId=#{last_received_id}}
		response = get(url)
		subscriptions = JSON.parse(response)['responses'].collect{ |subscriber|
			PremiumSubscriptionNumbers.new(subscriber['phoneNumber'], subscriber['id'])
		}

		#######Handle Errors
	end


private

	def validate_attributes(*attrs)
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