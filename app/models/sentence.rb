class Sentence < ApplicationRecord
  CHARACTERS = [
    { id: 1, name: "武", hiragana_name: "たけし", romaji_name: "Takeshi", avatar: "boy_3.png", voice_id: "flq6f7yk4E4fJM5XTYuZ" }, # Voice: Michael
    { id: 2, name: "リサ", hiragana_name: "リサ", romaji_name: "Risa", avatar: "girl_5.png", voice_id: "MF3mGyEYCl7XYWbV9V6O" }, # Voice: Elli
    { id: 3, name: "スタッフ", hiragana_name: "スタッフ", romaji_name: "Staff", avatar: "boy_3.png", voice_id: "5Q0t7uMcjvnagumLfvZi" } # Voice : Paul
  ]

  belongs_to :situation
  has_many :words, dependent: :destroy
  has_one_attached :audio

  validates :content, presence: true
  validates :translation, presence: true

  accepts_nested_attributes_for :words, allow_destroy: true

  def generate_translation_and_words_using_ai!
    response = Bot::Sentence.new(vars: { user_message: content }).chat
    self.translation = response["translation"]
    response["words"].each do |word|
      words.build(
        content: word["content"],
        reading_hiragana: word["reading_hiragana"],
        reading_romaji: word["reading_romaji"],
        translation: word["translation"]
      )
    end
    generate_audio
    save!
  end

  def character
    character = CHARACTERS.find { |character| character[:id] == character_id }
    character[:name_word] = Word.new(content: character[:name], reading_hiragana: character[:hiragana_name], reading_romaji: character[:romaji_name])
    OpenStruct.new(character)
  end

  def generate_audio!
    url = URI("https://api.elevenlabs.io/v1/text-to-speech/#{character.voice_id}/with-timestamps")

    headers = {
      "Content-Type" => "application/json",
      "xi-api-key" => Rails.application.credentials.elevenlabs.api_key
    }

    data = {
      text: content,
      model_id: "eleven_multilingual_v2",
      voice_settings: {
        stability: 0.5,
        similarity_boost: 0.75
      }
    }

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    headers.each { |key, value| request[key] = value }
    request.body = data.to_json

    response = http.request(request)

    if response.code != "200"
      Rails.logger.error "Error encountered, status: #{response.code}, content: #{response.body}"
      return
    end

    response_data = JSON.parse(response.body)

    # Decode the base64 audio data
    audio_data = Base64.decode64(response_data["audio_base64"])

    # Attach the audio file to the sentence
    audio.attach(
      io: StringIO.new(audio_data),
      filename: "sentence_#{id}.mp3",
      content_type: "audio/mpeg"
    )

    # Store the alignment data
    self.alignment_data = response_data["alignment"]
    save!
  end
end
