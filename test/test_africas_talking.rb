require 'helper'

class TestAfricasTalking < Minitest::Test
	include AfricasTalking


	context	"When connected"  do
		setup do
			@client_mock = setup_mock_client
		end
	end

protected
	
	def get_mock_body(name)
		File.open(@@mock_path + '/' + name).read
	end

	def setup_mock_client
		client = mock('Farady::Response')
		client.stubs(:finish).returns('')
		client.stubs(:status).returns(200)
		client.stubs(:headers).returns({"Accept"=>"application/json"})
		client.stubs(:body).returns(get_mock_body('.json'))
		Faraday::Response.stubs(:new).returns(:client)
	end
	
end