# frozen_string_literal: true

module LogExtractor
  class Extract
    method_object [:query!, { period: 15 }]

    def call(&block)
      @response = search.response
      while raw_hits.any?
        raw_hits.each { |raw_hit| parse_hit(raw_hit, &block) }
        @response = search.scroll
      end
    end

    private

    def raw_hits
      @response["hits"]["hits"]
    end

    def parse_hit(raw_hit)
      hit = Hit.new(source: raw_hit["_source"])
      yield hit
    end

    def search
      @search ||= Search.new(query: query, period: period)
    end
  end
end
