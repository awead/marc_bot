module MarcBot
  class FieldBuilder
    def self.call(**args)
      new(args.delete(:method), args.delete(:input), args).fields
    end

    attr_reader :method, :input

    def initialize(method, input, options)
      @method = method
      @input = input
    end

    # @return [MARC::ControlField, MARC::DataField]
    def fields
      if input.is_a?(String)
        data_or_control_field(input)
      elsif input.is_a?(Hash)
        MARC::DataField.new(tag, "0", " ", *subfield_array)
      else
        raise ArgumentError, "#{input.class} isn't a supported factory type"
      end
    end

    private

    def data_or_control_field(input)
      if MARC::ControlField.control_tag?(tag)
        MARC::ControlField.new(tag, input)
      else
        MARC::DataField.new(tag, "0", " ", ["a", input])
      end
    end

    def subfield_array
      input
        .to_a
        .map { |subfield| subfield.map(&:to_s) }
    end

    def tag
      @tag ||= begin
        result = method.to_s.match(/\d{3}/).to_s
        raise MarcBot::Error, "could not determine tag for :#{method}" if result == ""

        result
      end
    end
  end
end
