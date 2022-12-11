require_relative 'config/application'

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('payments')

def event_to_command(event_payload)
  case event_payload["type"]
  when "Payments::Events::PaymentRequested"
    data = event_payload["content"]["data"]
    Payments::Commands::RequestPayment.new( id: data["id"],
                                            amount: data["amount"],
                                            currency: data["currency"],
                                            description: data["description"],
                                          )
  end
end

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    payload = body
    command = event_to_command(payload)
    Rails.configuration.command_bus.(command) if command

    puts " [x] Received #{body}"
  end
rescue Interrupt => _
  connection.close

  exit(0)
end