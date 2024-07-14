class Admin::Contexts::BaseController < Admin::BaseController
  before_action :set_context

  private

  def set_context
    @context = Context.find(params[:context_id])
  end
end
