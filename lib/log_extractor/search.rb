# frozen_string_literal: true

module LogExtractor
  class Search
    SCROLL = "5m"

    rattr_initialize %i[query! period]

    def response
      client.search body: body, scroll: SCROLL
    end

    def scroll
      client.scroll body: { scroll_id: scroll_id }, scroll: SCROLL
    end

    private

    def body
      {
        query: body_query,
        sort: body_sort
      }
    end

    def body_query
      {
        bool: {
          must: [
            { range: body_query_range },
            { query_string: { query: query } }
          ]
        }
      }
    end

    def body_query_range
      {
        "@timestamp" => {
          gte: "now-#{period}m/m",
          lt: "now/m"
        }
      }
    end

    def body_sort
      [
        {
          "@timestamp" => {
            order: "desc"
          }
        }
      ]
    end

    def scroll_id
      @scroll_id ||= response["_scroll_id"]
    end

    def client
      @client ||= Elasticsearch::Client.new
    end
  end
end
