# require_relative '../../lib/configuration'
require 'arkency/command_bus'

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new(
    repository: RailsEventStoreActiveRecord::PgLinearizedEventRepository.new(serializer: YAML)
  )

  Rails.configuration.command_bus = Arkency::CommandBus.new

  cqrs = Infra::Cqrs.new(Rails.configuration.event_store, Rails.configuration.command_bus)

  Rails.configuration.cqrs = cqrs
  # Configuration.new.call(cqrs)
end
