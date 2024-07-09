class FlashcardsController < ApplicationController
  def index
    @words = Word.order("RANDOM()").limit(10)  # Fetch 10 random words
  end
end
