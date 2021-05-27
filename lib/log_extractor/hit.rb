module LogExtractor
  class Hit
    rattr_initialize %i[source]

    def syslog_message
      @syslog_message ||= source["syslog_message"]
    end

    def timestamp
      @timestamp ||= DateTime.rfc3339(timestamp_raw).to_time
    end

    private

    def timestamp_raw
      @timestamp_raw ||= source["@timestamp"]
    end
  end
end
