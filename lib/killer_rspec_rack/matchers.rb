module KillerRspecRack
  module Matchers
    ::RSpec::Matchers.define :be_ok_and_json do
      match do |response|
        response.ok? && KillerRspecRack::Matchers.has_content_type?(response, "application/json")
      end

      failure_message_for_should do |response|
        "expected response to be ok and json, but was '#{response.ok? ? "OK" : "NOT OK"}' and '#{response.headers['Content-Type']}'"
      end

      failure_message_for_should_not do |response|
        "expected response to be not ok and not json, but was '#{response.ok? ? "OK" : "NOT OK"}' and '#{response.headers['Content-Type']}'"
      end
    end

    ::RSpec::Matchers.define :be_unauthorized do
      match do |response|
        response.status == 401
      end

      failure_message_for_should do |response|
        "expected response to be (401 Unauthorized), but was #{response.status}"
      end

      failure_message_for_should_not do |response|
        "expected response not to be (401 Unauthorized), but was"
      end
    end

    def self.has_header? response, header, value
      response.headers[header] == value.to_s
    end

    def self.has_content_type? response, value
      response.headers["Content-Type"].include? value.to_s
    end

    ::RSpec::Matchers.define :have_header do |header, value|
      match do |response|
        KillerRspecRack::Matchers.has_header? response, header, value
      end

      failure_message_for_should do |response|
        "expected response to have header '#{header}=>#{value}', but did not"
      end

      failure_message_for_should_not do |response|
        "expected response not to have header '#{header}=>#{value}', but did"
      end
    end

    ::RSpec::Matchers.define :have_content_type do |value|
      match do |response|
        KillerRspecRack::Matchers.has_content_type? response, value
      end

      failure_message_for_should do |response|
        "expected response to have header 'Content-Type=>#{value}', but did not"
      end

      failure_message_for_should_not do |response|
        "expected response to not have header 'Content-Type=>#{value}', but did"
      end
    end

    ::RSpec::Matchers.define :have_content_length do |value|
      match do |response|
        KillerRspecRack::Matchers.has_header? response, "Content-Length", value
      end

      failure_message_for_should do |response|
        "expected response to have header 'Content-Length=>#{value}', but did not"
      end

      failure_message_for_should_not do |response|
        "expected response to not have header 'Content-Length=>#{value}', but did"
      end
    end
  end
end
