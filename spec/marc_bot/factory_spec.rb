RSpec.describe MarcBot::Factory do
  let(:factory) { described_class.new }

  describe "#method_missing" do
    context "when :leader" do
      it "yields the content to the leader" do
        expect(factory.leader { "whatever the leader is" }).to eq("whatever the leader is")
      end
    end

    context "when any other action" do
      before { allow(MarcBot::FieldBuilder).to receive(:call) }

      it "passes it on to the field builder" do
        factory.some_action { "some input" }
        expect(MarcBot::FieldBuilder).to have_received(:call).with(method: :some_action, input: "some input", args: [])
      end
    end
  end
end
