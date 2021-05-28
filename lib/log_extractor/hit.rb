# frozen_string_literal: true

module LogExtractor
  class Hit
    rattr_initialize %i[source]

    def method_missing(method_name, *_args, &_block)
      value = source[method_name.to_s]
      value.nil? ? super : value
    end

    def respond_to_missing?(method_name, *_args)
      !source[method_name.to_s].nil?
    end

    def timestamp
      DateTime.rfc3339(source["@timestamp"]).to_time
    end
  end
end
