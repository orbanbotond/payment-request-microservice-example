module Rabbitmq
  class Publisher
  	def initialize
  		@connection = Bunny.new
			@connection.start
			@channel = @connection.create_channel
			@queue = @channel.queue('payments')
  	end

    def call(cqrs)
      @cqrs = cqrs

      @cqrs.subscribe(rabbit_mq_publisheer, [Payments::Events::PaymentRequested])
    end

    private

    def rabbit_mq_publisheer
      ->(event) do
        payload = { type: event.class , content: event.as_json }.to_json
        @channel.default_exchange.publish(payload, routing_key: @queue.name)
      end
    end
  end
end

