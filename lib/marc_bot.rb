# frozen_string_literal: true

require "marc"

module MarcBot
  require "marc_bot/field_builder"
  require "marc_bot/version"

  class Error < StandardError; end

  def self.define(&block)
    instance_exec(&block)
  end

  def self.factory(record_name, &block)
    @record_factory = Factory.new(record_name)
    @record_factory.instance_exec(&block)
  end

  def self.build(record_symbol)
    @record_factory.record
  end

  class Factory
    attr_reader :record

    def initialize(record_name)
      @record = MARC::Record.new
    end

    def method_missing(method, *args, &block)
      if method == :leader
        record.leader = yield
      else
        record.append MarcBot::FieldBuilder.call(method: method, input: yield, args: args)
      end
    end

    def respond_to_missing?
      super
    end
  end
end
