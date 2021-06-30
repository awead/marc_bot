# frozen_string_literal: true

require "marc"

module MarcBot
  require "marc_bot/factory"
  require "marc_bot/field_builder"
  require "marc_bot/find_definitions"
  require "marc_bot/registry"
  require "marc_bot/version"

  class Error < StandardError; end

  class << self
    def define(&block)
      instance_exec(&block)
    end

    def factory(record_name, &block)
      block ||= ->(result) { result }
      factories.register(record_name, block)
    end

    def build(record_symbol, *args)
      find_definitions if factories.nil?

      record_factory = factories.find(record_symbol)
      factory = Factory.new
      factory.instance_exec(&record_factory)
      factory.record
    end

    def reload
      @factories = nil
      find_definitions
    end

    def factories
      @factories ||= Registry.new("Factory")
    end
  end
end
