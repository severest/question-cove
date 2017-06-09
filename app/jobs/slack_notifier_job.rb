require "net/http"
require "uri"
require "json"

class SlackNotifierJob < ApplicationJob
  queue_as :default

  def perform(text)
    parms = {
        text: text,
        username: "QuestionCove",
        icon_emoji: ":question:",
        mrkdwn: true
    }

    uri = URI.parse(Rails.application.config.slack_webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = parms.to_json

    http.request(request)
  end
end
