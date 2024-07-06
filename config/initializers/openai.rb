OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.open_ai[:api_key]
  # config.organization_id = ENV.fetch("OPENAI_ORGANIZATION_ID") # Optional
  config.log_errors = true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.
end
