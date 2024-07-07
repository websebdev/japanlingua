class SituationsController < ApplicationController
  before_action :set_text_options, only: [ :show ]

  def index
    @situations = Situation.all
  end

  def show
    @situation = Situation.find(params[:id])
  end

  private

  def set_text_options
    if params[:text_furigana] == "true"
      cookies[:text_furigana] = true
    else
      cookies.delete(:text_furigana) if cookies[:text_furigana].present?
    end
    if params[:text_english] == "true"
      cookies[:text_english] = true
    else
      cookies.delete(:text_english) if cookies[:text_english].present?
    end
  end
end
