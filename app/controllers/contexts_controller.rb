class ContextsController < ApplicationController
  def index
    @contexts = Context.includes(:situations, :reviews, :words).all
  end

  def show
    @context = Context.find(params[:id])
  end
end
