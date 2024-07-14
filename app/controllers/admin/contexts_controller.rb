class Admin::ContextsController < Admin::BaseController
  def index
    @contexts = Context.all.order(:name)
  end

  def show
    @context = Context.find(params[:id])
    @situations = @context.situations.order(:title)
  end
end
