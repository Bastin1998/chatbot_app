class ChatController < ApplicationController
  def index
  end

def ask
    prompt = params[:question]

    response = Faraday.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyC5bICthu3p4CmJjkTVQZMnU-WCWZQTTOE") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        contents: [{ parts: [{ text: 'Is there any gem to integrate gemini ai in rails app' }] }]
      }.to_json
    end

    if response.success?
      json = JSON.parse(response.body)
      @answer = json.dig("candidates", 0, "content", "parts", 0, "text")
    else
      @answer = "Error: #{response.status} - #{response.body}"
    end

    respond_to do |format|
      format.js
    end
  end
end
