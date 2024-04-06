require_relative "../../payments/lib/payments"

class Configuration
  def call(cqrs)
    enable_domains(cqrs)
    enable_read_models(cqrs)
    enable_event_publishing(cqrs)
  end

  private

  def enable_domains(cqrs)
    Payments::Configuration.new.call(cqrs)
  end

  def enable_read_models(cqrs)
    Payments::PaymentRequestReport::Configuration.new.call(cqrs)
  end

  def enable_event_publishing(cqrs)
    PubSub::Publisher.new.call(cqrs)
  end
end
