module Infra
  module TestPlumbing
    class FakeCommandBus
      attr_reader :last_received, :all_received

      def initialize
        @all_received = []
      end

      def call(command)
        @last_received = command
        @all_received << command
      end

      def register(command, handler)
      end
    end

    def self.included(klass)
      klass.send(:let, :command_bus) { CommandBus.new }
      klass.send(:let, :event_store) { EventStore.in_memory }
      klass.send(:let, :cqrs) { Cqrs.new(event_store, command_bus) }

      include TestMethodsForAggregateTesting
      include TestMethodsForProcessTesting
    end

    module TestMethodsForProcessTesting
      def given(events, store: event_store, process:)
        events.each { |ev| store.append(ev) }
        events.each{|event| process.(event)}
      end
      alias process_events given

      def expect_have_been_commanded(*expected_commands)
        expected_commands.all? do |expected_command|
          expect(command_bus.all_received ).to include(expected_command)
        end
      end

      def expect_nothing_have_been_commanded
        expect(command_bus.all_received ).to be_empty
      end
    end

    module TestMethodsForAggregateTesting
      def arrange(*commands)
        commands.each { |command| act(command) }
      end
      alias run_commands arrange

      def act(command)
        command_bus.(command)
      end
      alias run_command act

      extend RSpec::Matchers::DSL

      matcher :publish_in_stream do |stream_name, *expected_events|
        match do |code|
          scope = event_store.read.stream(stream_name)
          before = scope.last
          code.call
          actual_events =
            before.nil? ? scope.to_a : scope.from(before.event_id).to_a
          to_compare = ->(ev) { { type: ev.event_type, data: ev.data } }
          expected_events.map(&to_compare) == actual_events.map(&to_compare)
        end

        supports_block_expectations
      end

      matcher :be_published_in_stream do |stream_name|
        match do |*expected_events|
          scope = event_store.read.stream(stream_name)
          actual_events = scope.to_a
          to_compare = ->(ev) { { type: ev.event_type, data: ev.data } }
          expected_events.map(&to_compare) == actual_events.map(&to_compare)
        end
      end

      def assert_changes(actuals, expected)
        expects = expected.map(&:data)
        assert_equal(expects, actuals.map(&:data))
      end
    end
  end
end
