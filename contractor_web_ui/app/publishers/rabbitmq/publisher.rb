module Rabbitmq
  class Publisher
  	def initialize
  		@connection = Bunny.new
			@connection.start
      # create a channel with confirm select
			@channel = @connection.create_channel
			@queue = @channel.queue('payments', durable: true)
  	end

    def call(cqrs)
      @cqrs = cqrs
      puts "Enabled RabbitMQ publishing"
      @cqrs.subscribe(rabbit_mq_publisheer, [Payments::Events::PaymentRequested])
      puts "Enabled RabbitMQ publishing DONE"
    end

    private

    def rabbit_mq_publisheer
      puts "Passing publisher method to RabbitMQ publishing"
      m = ->(event) do
        puts "Publishing event to rabbitmq"
        puts "Publishing event to rabbitmq"
        puts "Publishing event to rabbitmq"
        payload = { type: event.class , content: event.as_json }.to_json
        @queue.publish(payload, persistent: true)
        puts "Publishing event to rabbitmq DONE"
        puts "Publishing event to rabbitmq DONE"
        puts "Publishing event to rabbitmq DONE"
      end
      puts "Passing publisher method to RabbitMQ publishing DONE"
      m
    end
  end
end

