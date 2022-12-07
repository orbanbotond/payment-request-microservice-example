# frozen_string_literal: true

require "aggregate_root"
require "arkency/command_bus"
require "ruby_event_store"
require "dry-struct"
require "dry-types"

require_relative "infra/aggregate_root_repository"
require_relative "infra/event"
require_relative "infra/cqrs"
require_relative "infra/command"

include_testing = if defined?(Rails)
	true if Rails.env.testing?
else
	true
end

require_relative "infra/testing" if include_testing
require_relative "infra/command_bus"
require_relative "infra/event_store"
