class Bot
  def initialize(vars: {})
    @client = OpenAI::Client.new
    @vars = vars
  end

  def chat
    response = @client.chat(
    parameters: {
        model: "gpt-4o", # Required.
        response_format: { type: "json_object" },
        messages: [
          { role: "system", content: system_message },
          { role: "user", content: @vars[:user_message] }
        ], # Required.
        temperature: 0.7
    })
    JSON.parse(response.dig("choices", 0, "message", "content"))
  rescue StandardError => e
    if Rails.env.development?
      binding.irb
    else
      raise e
    end
  end
end
