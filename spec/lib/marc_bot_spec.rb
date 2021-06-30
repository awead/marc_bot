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

  describe "unsupported options" do
    it "raises an error" do
      expect {
        MarcBot.define do
          factory :bad_record do
            badfield { "this is an error" }
          end
        end
      }.to raise_error(MarcBot::Error, "could not determine tag for :badfield")
    end
  end
end
