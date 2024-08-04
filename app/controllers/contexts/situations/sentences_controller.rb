class Contexts::Situations::SentencesController < Contexts::Situations::BaseController
  def show
    sentences = @situation.sentences.order(:id)
    @sentence = sentences.find(params[:id])

    next_sentence_index = sentences.order(:id).index { |s| s == @sentence }
    @next_sentence = @next_sentence_index = sentences[next_sentence_index + 1]
  end
end
