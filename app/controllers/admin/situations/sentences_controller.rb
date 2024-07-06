class Admin::Situations::SentencesController < Admin::Situations::BaseController
  before_action :set_sentence, only: [ :destroy ]

  def create
    @sentence = @situation.sentences.create!(sentence_params)

    redirect_to admin_situation_path(@situation), notice: "Sentence was successfully created."
  end

  def destroy
    @sentence.destroy
    redirect_to admin_situation_path(@situation), notice: 'Sentence was successfully deleted.'
  end

  private

  def sentence_params
    params.require(:sentence).permit(:content, :translation)
  end

  def set_sentence
    @sentence = @situation.sentences.find(params[:id])
  end
end
