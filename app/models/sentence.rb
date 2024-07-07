class Sentence < ApplicationRecord
  CHARACTERS = [
    { id: 1, name: "武", hiragana_name: "たけし", romaji_name: "Takeshi", avatar: "boy_3.png" },
    { id: 2, name: "エミリー", hiragana_name: "エミリー", romaji_name: "Emily", avatar: "girl_5.png" }
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
    save!
  end

  def character
    character = CHARACTERS.find { |character| character[:id] == character_id }
    character[:name_word] = Word.new(content: character[:name], reading_hiragana: character[:hiragana_name], reading_romaji: character[:romaji_name])
    OpenStruct.new(character)
  end
end
