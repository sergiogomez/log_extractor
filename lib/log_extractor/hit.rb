module LogExtractor
  class Hit
    rattr_initialize %i[source]

    def syslog_message
      # rubocop:disable Security/Eval
      @syslog_message ||= eval syslog_message_value
      # rubocop:enable Security/Eval
    end

    def timestamp
      @timestamp ||= DateTime.rfc3339(timestamp_raw).to_time
    end

    private

    def timestamp_raw
      @timestamp_raw ||= source["@timestamp"]
    end

    def syslog_message_raw
      @syslog_message_raw ||= source["syslog_message"]
    end

    def syslog_message_value
      @syslog_message_value ||= syslog_message_raw.sub(/\[.*\]: /, "")
    end
  end
end
