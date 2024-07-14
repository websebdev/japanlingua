class Admin::SituationsController < Admin::BaseController
  before_action :set_situation, only: [ :edit, :update, :destroy ]

  def new
    @situation = Situation.new
  end

  def edit
  end

  def create
    @situation = Situation.new(situation_params)

    respond_to do |format|
      if @situation.save
        format.turbo_stream
        format.html { redirect_to admin_situations_path, notice: "Situation was successfully created." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_situation", partial: "form", locals: { situation: @situation })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @situation.update(situation_params)
        format.turbo_stream
        format.html { redirect_to admin_situations_path, notice: "Situation was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@situation, partial: "form", locals: { situation: @situation })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @situation.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_situations_path, notice: "Situation was successfully destroyed." }
    end
  end

  private

  def set_situation
    @situation = Situation.find(params[:id])
  end

  def situation_params
    params.require(:situation).permit(:title, :description, :difficulty_level, :context_id)
  end
end
