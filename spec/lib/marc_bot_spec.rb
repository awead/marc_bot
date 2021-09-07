# frozen_string_literal: true

RSpec.describe MarcBot do
  it "has a version number" do
    expect(MarcBot::VERSION).not_to be nil
  end

  describe "building a new record" do
    let(:sample) { MarcBot.build(:example) }

    it "returns MARC record" do
      expect(sample).to be_a(MARC::Record)
      expect(sample.leader).to eq("1234567890")
      expect(sample["006"].value).to eq("00000000000000")
      expect(sample["100"]["a"]).to eq("The Author")
      expect(sample["245"]["a"]).to eq("Title A")
      expect(sample["245"]["b"]).to eq("Title B")
    end
  end

  describe "building with options" do
    let(:sample) { MarcBot.build(:example, f949: {t: "ML 410 .B117 2020", w: "LC"}) }

    it "returns MARC record" do
      expect(sample).to be_a(MARC::Record)
      expect(sample["949"]["t"]).to eq("ML 410 .B117 2020")
      expect(sample["949"]["w"]).to eq("LC")
    end
  end

  describe "building with multiple fields" do
    let(:sample) { MarcBot.build(:multifield) }

    it "returns a record with all fields" do
      expect(sample).to be_a(MARC::Record)
      expect(sample.fields[0].subfields.map(&:value)).to contain_exactly("A", "B1", "B2", "C", "D")
      expect(sample.fields[1].subfields.map(&:value)).to contain_exactly("A", "B")
    end
  end

  describe "unsupported options" do
    before do
      MarcBot.define do
        factory :bad_record do
          badfield { "this is an error" }
        end
      end
    end

    it "raises an error" do
      expect {
        MarcBot.build(:bad_record)
      }.to raise_error(MarcBot::Error, "could not determine tag for :badfield")
    end
  end
end
