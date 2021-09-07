module MarcBot
  class FieldBuilder
    SKIP_KEYS = %i[
      indicator1
      indicator2
    ]

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
        MARC::DataField.new(tag, indicator1, indicator2, *subfield_array)
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
        .reject { |key, _value| SKIP_KEYS.include?(key) }
        .map { |key, value| build_subfield_array(key, value) }
        .flatten
        .each_slice(2)
        .to_a
    end

    def build_subfield_array(key, value)
      key = key.to_s
      return [key, value] unless value.is_a?(Array)

      value.map { |v| [key, v] }
    end

    def tag
      @tag ||= begin
        result = method.to_s.match(/\d{3}/).to_s
        raise MarcBot::Error, "could not determine tag for :#{method}" if result == ""

        result
      end
    end

    def indicator1
      input.fetch(:indicator1, "0")
    end

    def indicator2
      input.fetch(:indicator2, " ")
    end
  end
end
