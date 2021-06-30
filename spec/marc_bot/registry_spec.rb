RSpec.describe MarcBot::Registry do
  subject(:registry) { described_class.new(:test_factory) }

  describe "#clear" do
    its(:clear) { is_expected.to eq({}) }
  end

  describe "#find" do
    context "when the item doesn't exist" do
      it "raises an error" do
        expect {
          registry.find(:unknown)
        }.to raise_error(MarcBot::Error, "item :unknown does not exist in the registry. Did you define it?")
      end
    end

    context "when the item does exist" do
      before { registry.register(:found, "thing") }

      it "returns the item" do
        expect(registry.find(:found)).to eq("thing")
      end
    end
  end

  describe "#register" do
    it "adds an item to the registry" do
      expect(registry.registered?(:item)).to be(false)
      registry.register(:item, "value")
      expect(registry.registered?(:item)).to be(true)
    end
  end
end
