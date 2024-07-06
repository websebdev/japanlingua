class Sentence < ApplicationRecord
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
end
