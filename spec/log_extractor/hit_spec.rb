# frozen_string_literal: true

RSpec.describe LogExtractor::Hit do
  let(:source_existing_field) { "Existing field" }
  let(:source_timestamp) { "2021-05-28T07:34:46.424Z" }
  let(:source) do
    {
      "existing_field" => source_existing_field,
      "@timestamp" => source_timestamp
    }
  end

  subject(:hit) { described_class.new(source: source) }

  describe "#existing_field" do
    subject(:existing_field) { hit.existing_field }

    it { expect(existing_field).to eq source_existing_field }
  end

  describe "#timestamp" do
    let(:expected_timestamp) { DateTime.rfc3339(source_timestamp).to_time }

    subject(:timestamp) { hit.timestamp }

    it { expect(timestamp).to eq expected_timestamp }
  end

  describe "#non_existing_field" do
    subject(:non_existing_field) { hit.non_existing_field }

    it { expect { non_existing_field }.to raise_error NoMethodError }
  end
end
