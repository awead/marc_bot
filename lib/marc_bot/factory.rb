module MarcBot
  class Factory
    attr_reader :record

    def initialize
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
