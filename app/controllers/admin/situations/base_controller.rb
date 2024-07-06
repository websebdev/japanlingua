class Admin::Situations::BaseController < ApplicationController
  before_action :set_situation

  private

  def set_situation
    @situation = Situation.find(params[:situation_id])
  end
end
