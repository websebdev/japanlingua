class Admin::BaseController < ApplicationController
  before_action :require_admin
  before_action :set_admin_layout

  private

  def require_admin
    redirect_to root_path unless Current.user&.admin?
  end

  def set_admin_layout
    @admin_layout = true
  end
end
