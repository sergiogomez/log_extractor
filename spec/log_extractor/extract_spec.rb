# frozen_string_literal: true

require "pry"

RSpec.describe LogExtractor::Extract do
  let(:query) { "query" }
  let(:period) { 15 }

  let(:search_double) { instance_double(LogExtractor::Search) }
  let(:source_existing_field) { "Existing field" }
  let(:source_timestamp) { "2021-05-28T07:34:46.424Z" }
  let(:source) do
    {
      "existing_field" => source_existing_field,
      "@timestamp" => source_timestamp
    }
  end
  let(:hit) { { "_source" => source } }

  let(:search_response) { { "hits" => { "hits" => [hit, hit] } } } # 2 hits

  let(:scroll_response_first) { { "hits" => { "hits" => [hit, hit] } } } # 2 hits
  let(:scroll_response_second) { { "hits" => { "hits" => [hit] } } } # 1 hit
  let(:scroll_response_third) { { "hits" => { "hits" => [] } } } # no more hits

  subject(:extract) { described_class.(query: query, period: period) }

  before do
    allow(LogExtractor::Search).to receive(:new).and_return(search_double)
    allow(search_double).to receive(:response).and_return(search_response)
    allow(search_double).to receive(:scroll).and_return(
      scroll_response_first, scroll_response_second, scroll_response_third
    )
  end

  it "is yielding a block five times" do
    expect do |block|
      described_class.(query: query, period: period, &block)
    end.to yield_control.exactly(5).times
  end

  context "when there are no hits" do
    let(:search_response) { { "hits" => { "hits" => [] } } } # no hits

    it "is not yielding any block" do
      expect do |block|
        described_class.(query: query, period: period, &block)
      end.not_to yield_control
    end
  end

  context "when there is no scroll from search" do
    let(:scroll_response_first) { { "hits" => { "hits" => [] } } } # no hits

    it "is yielding a block twice" do
      expect do |block|
        described_class.(query: query, period: period, &block)
      end.to yield_control.twice
    end
  end
end
