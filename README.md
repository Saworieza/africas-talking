#Africas Talking.
A fast lightweight and minimalist wrapper around the Africas Talking api


[![Build Status](https://travis-ci.org/chalchuck/africas-talking.svg?branch=master)](https://travis-ci.org/chalchuck/africas-talking)
[![Dependency Status](https://gemnasium.com/chalchuck/africas-talking.svg)](https://gemnasium.com/chalchuck/africas-talking)
[![Code Climate](https://codeclimate.com/github/chalchuck/africas-talking/badges/gpa.svg)](https://codeclimate.com/github/chalchuck/africas-talking)
[![Test Coverage](https://codeclimate.com/github/chalchuck/africas-talking/badges/coverage.svg)](https://codeclimate.com/github/chalchuck/africas-talking/coverage)

## Installation

Add this line to your application's Gemfile:

    gem 'africas_talking'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install africas_talking


##Setup

Obtain a Client ID and Secret
---
1. Go to Africas Talking website. (https://account.africastalking.com/register)
2. In the sidebar on the left, select Settings > Api Key
3. If you haven't generated your key already, generate a new api key credentials by clicking Generate My Api Key


## Usage
###Sending a message
```ruby
	AfricasTalking::Message.new.deliver(recipients, message, username)
```
Recipients:
	This are the numbers that you want to send to, 
	If you want to send to many people delimit the numbers using commas(',') 
	for example: "0700000000, 0710000000, 0720000000"

Message:
	This is the message content 
	A message is by default 160 characters
	If your message is 161-320 it will be sent as two messages and so on

Username:
	This is your username on AfricasTalking.com 
	[If you do not have one signup and use it to send messages]
		
###Sending message using sender id or shortcode parameter
```ruby
	AfricasTalking::Message.new.deliver_with_shortcode(recipients, message, from, username)
```
Specify your AfricasTalking shortCode or sender id, sender = "shortCode or senderId"

###Enqueue messages
```ruby
	AfricasTalking::Message.new.enqueue_messages(options)
```
Enqueue flag is used to queue messages incase you are sending a high volume.

sender = nil # sender = "shortCode or sender id"
bulkSMSMode = 1 # This should always be 1 for bulk messages
The default value for enqueue is 0.

So as to send/enqueue a message, build a hash with the following options: 
	{recipients: "", message: "", sender: "", enqueue: "", bulkSMSMode: "", username: ""}





## Contributing

1. Fork it ( https://github.com/[my-github-username]/africas_talking/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
