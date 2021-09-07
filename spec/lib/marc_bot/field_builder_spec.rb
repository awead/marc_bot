RSpec.describe MarcBot::FieldBuilder do
  subject { builder.to_s }

  let(:builder) { described_class.call(method: method, input: input) }

  let(:control_tag) do
    MARC::ControlField
      .control_tags
      .to_a
      .sample
  end

  context "with a data field string" do
    let(:method) { :f245 }
    let(:input) { Faker::Lorem.sentence }

    it { is_expected.to eq("245 0  $a #{input} ") }
  end

  context "with a control field string" do
    let(:method) { "f#{control_tag}".to_sym }
    let(:input) { Faker::Number.leading_zero_number(digits: 10) }

    it { is_expected.to eq("#{control_tag} #{input}") }
  end

  context "with a hash of subfields" do
    let(:method) { :f100 }

    let(:input) do
      {
        a: a_input,
        b: b_input
      }
    end

    let(:a_input) { Faker::Name.name }
    let(:b_input) { Faker::Name.name }

    it { is_expected.to eq("100 0  $a #{a_input} $b #{b_input} ") }
  end

  context "with a hash including indicator fields" do
    let(:method) { :f100 }

    let(:input) do
      {
        indicator1: "1",
        indicator2: "2",
        a: a_input
      }
    end

    let(:a_input) { Faker::Name.name }

    it { is_expected.to eq("100 12 $a #{a_input} ") }
  end

  context "with repeated subfields" do
    let(:method) { :f650 }

    let(:input) do
      {
        x: a_input,
        z: [b_input, c_input]
      }
    end

    let(:a_input) { Faker::Name.name }
    let(:b_input) { Faker::Name.name }
    let(:c_input) { Faker::Name.name }

    it { is_expected.to eq("650 0  $x #{a_input} $z #{b_input} $z #{c_input} ") }
  end

  context "with an unsupported factory type" do
    it "raises and error" do
      expect {
        described_class.call(method: :f100, input: ["asdf"])
      }.to raise_error(ArgumentError, "Array isn't a supported factory type")
    end
  end
end
