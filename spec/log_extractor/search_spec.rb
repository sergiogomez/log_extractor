# frozen_string_literal: true

RSpec.describe LogExtractor::Search do
  let(:query) { "query" }
  let(:period) { 15 }

  let(:elasticsearch_client) { Elasticsearch::Client.new }
  let(:elasticsearch_response) { object_double(:elasticsearch_response) }
  let(:elasticsearch_scroll) { object_double(:elasticsearch_scroll) }
  let(:elasticsearch_scroll_id) { "FGluY2x1ZGVfY29udGV4dF91S3dJTnc=" }

  subject(:search) { described_class.new(query: query, period: period) }

  before do
    allow(Elasticsearch::Client).to receive(:new).and_return(elasticsearch_client)
    allow(elasticsearch_client).to receive(:search).and_return(elasticsearch_response)

    allow(search).to receive(:scroll_id).and_return(elasticsearch_scroll_id)
    allow(elasticsearch_client).to receive(:scroll).and_return(elasticsearch_scroll)
  end

  describe "#response" do
    subject(:response) { search.response }

    it { expect(response).to eq elasticsearch_response }
  end

  describe "#scroll" do
    subject(:scroll) { search.scroll }

    it { expect(scroll).to eq elasticsearch_scroll }
  end

  context "without a period" do
    subject(:search) { described_class.new(query: query) }

    describe "#response" do
      subject(:response) { search.response }

      it { expect(response).to eq elasticsearch_response }
    end

    describe "#scroll" do
      subject(:scroll) { search.scroll }

      it { expect(scroll).to eq elasticsearch_scroll }
    end
  end
end
