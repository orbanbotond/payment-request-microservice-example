module Payments
  class PaymentRequest
    include AggregateRoot

    CanRequestOnlyAfterInit = Class.new(StandardError)
    CanRejectOnlyARequestedPayment = Class.new(StandardError)
    CanApproveOnlyARequestedPayment = Class.new(StandardError)

    def initialize(id)
      @id = id
      @state = :created
    end

    def request(command)
      raise CanRequestOnlyAfterInit unless @state == :created

      requested_event = Events::PaymentRequested.new( data: { id: @id, amount: command.amount, currency: command.currency, description: command.description } )

      apply requested_event
    end

    def reject(command)
      raise CanRejectOnlyARequestedPayment unless @state == :requested

      rejected_event = Events::PaymentRejected.new( data: { id: @id, cause_of_rejection: command.cause_of_rejection } )

      apply rejected_event
    end

    def approve(command)
      raise CanApproveOnlyARequestedPayment unless @state == :requested

      approved_event = Events::PaymentApproved.new( data: { id: @id } )

      apply approved_event
    end

  private

    on Events::PaymentRequested do |event|
      @state = :requested
      @amount = event.data[:amount]
      @description = event.data[:description]
      @currency = event.data[:currency]
    end

    on Events::PaymentRejected do |event|
      @state = :rejected
      @cause_of_rejection = event.data[:cause_of_rejection]
    end

    on Events::PaymentApproved do |event|
      @state = :approved
    end
  end
end
