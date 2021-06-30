module MarcBot
  class Registry
    include Enumerable

    attr_reader :name

    def initialize(name)
      @name = name
      @items = {}
    end

    def clear
      items.clear
    end

    def find(name)
      items[name] || raise(Error, "item :#{name} does not exist in the registry. Did you define it?")
    end
    alias_method :[], :find

    def register(name, item)
      items[name] = item
    end

    def registered?(name)
      items.key?(name)
    end

    private

    attr_reader :items
  end
end
