class AfricasTalking::Base

  BASE_URI = 'https://api.africastalking.com'
  attr_accessor :username, :apikey

  def initialize(username, apikey)
    @username = username
    @apikey = apikey
  end

  def prepare_recipients(recipients)
    recipients_array = []
    recipients.split(',').each { |r| recipients_array << format_mobile(r) }
    recipients_array.join(', ')
  end

  def post(url, body=nil)
    response = Typhoeus.post("#{BASE_URI}#{url}", body: body, headers: headers)
    # process_api_response(response)
    JSON.parse(response.body)
  end

  def get(url)
    response = Typhoeus.post("#{BASE_URI}#{url}", headers: headers)
    response.options[:response_code].eql?(200) ? build_messages_array(response) : api_error_messages(response)
  end

  def build_messages_array(response)
    parsed_response = parse_api_response(response)["SMSMessageData"]["Messages"]
    parsed_response.collect { |msg| AfricasTalking::SMSMessage.new(msg["id"], msg["text"], msg["from"] , msg["to"], msg["linkId"], msg["date"])}
  end

  def parse_api_response(response)
    JSON.parse(response.body)
  end

  def process_api_response(response)
    return parse_api_response(response) if response.options[:response_code].eql?(200)
    return parse_status_reports(response) if response.options[:response_code].eql?(201)
    return api_error_messages(response) unless response.options[:response_code].eql?(200|201)
  end

  def parse_status_reports(response)
    reports = parse_api_response(response)["SMSMessageData"]["Recipients"]
    reports.collect {|report| AfricasTalking::StatusReport.new(report["number"], report["status"], report["cost"])}
  end

  def api_error_messages(response)
    response.body
  end

  def format_mobile(mobile_number)
    mobile_number.strip.gsub(/^0/,'+254')# if mobile_number.present?
  end

  def headers
    {
      'Accept' => "application/json", 'apiKey' => apikey
    }
  end

end