class ContextsController < ApplicationController
  def index
    @contexts = Context.all
  end

  def show
    @context = Context.find(params[:id])
  end
end
