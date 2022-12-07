# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "infra"
  spec.version = "1.0.0"
  spec.authors = ["Logic Optimum"]
  spec.email = ["orbanbotond@gmail.com"]
  spec.require_paths = ["lib"]
  spec.files = Dir["lib/**/*"]
  spec.summary = "infrastructure for the application"

  spec.add_dependency "aggregate_root"
  spec.add_dependency "ruby_event_store"
  spec.add_dependency "arkency-command_bus"
  spec.add_dependency "dry-struct"
  spec.add_dependency "dry-types"
end
