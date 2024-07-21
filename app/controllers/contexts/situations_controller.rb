class Contexts::SituationsController < Contexts::BaseController
  before_action :set_text_options, only: [ :show ]

  def index
    @situations = Situation.all
  end

  def show
    @situation = @context.situations.find(params[:id])
    @sentences = @situation.sentences
    @current_sentence_index = params[:sentence_index]&.to_i || 0
    @show_all = params[:show_all] == "true"

    SrsSystem.new(Current.user).add_new_words(@situation) if Current.user

    if @show_all
      render "show_all"
    end
  end

  private

  def set_text_options
    cookies[:text_furigana] = params[:text_furigana] if params[:text_furigana]
    cookies[:text_english] = params[:text_english] if params[:text_english]
    cookies[:text_japanese] = params[:text_japanese] if params[:text_japanese]
    cookies[:text_romaji] = params[:text_romaji] if params[:text_romaji]
  end
end
