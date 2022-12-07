require 'infra'

require_relative 'events'
require_relative 'commands'
require_relative 'payment_request'

module Payments
	class RequestPaymentHandler
		def initialize(event_store)
      @repository = Infra::AggregateRootRepository.new(event_store)
		end

    def call(command)
      @repository.with_aggregate(PaymentRequest, command.id) do |payment_request|
        payment_request.request(command)
      end
    end
	end

	class RejectPaymentHandler
		def initialize(event_store)
      @repository = Infra::AggregateRootRepository.new(event_store)
		end

    def call(command)
      @repository.with_aggregate(PaymentRequest, command.id) do |payment_request|
        payment_request.reject(command)
      end
    end
	end

	class ApprovePaymentHandler
		def initialize(event_store)
      @repository = Infra::AggregateRootRepository.new(event_store)
		end

    def call(command)
      @repository.with_aggregate(PaymentRequest, command.id) do |payment_request|
        payment_request.approve(command)
      end
    end
	end

	class Configuration
		def call(cqrs)
			register_commands(cqrs)
		end

private

		def register_commands(cqrs)
			cqrs.register_command(Commands::RequestPayment, RequestPaymentHandler.new(cqrs.event_store), Events::PaymentRequested)
			cqrs.register_command(Commands::RejectPayment, RejectPaymentHandler.new(cqrs.event_store), Events::PaymentRejected)
			cqrs.register_command(Commands::ApprovePayment, ApprovePaymentHandler.new(cqrs.event_store), Events::PaymentApproved)
		end
	end
end
