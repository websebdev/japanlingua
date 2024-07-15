class Contexts::ReviewsController < Contexts::BaseController
  before_action :require_login

  def index
    @reviews = Current.user.reviews
      .where("next_review_date <= ?", Time.current.end_of_day)
      .where(context: @context)
      .includes(:word, :context)
      .order(:next_review_date)

    @reviews = @reviews.where(context: @context)

    @words = @reviews.extract_associated(:word)
  end

  def update
    @review = Current.user.reviews.find(params[:id])
    if @review
      known = ActiveModel::Type::Boolean.new.cast(params[:known])
      srs_service = SrsSystem.new(Current.user)
      srs_service.process_review(@review, known)
      render json: { success: true, next_review_date: @review.next_review_date }
    else
      render json: { success: false, error: "Review not found" }, status: :not_found
    end
  end

  private

  def require_login
    redirect_to signin_path unless Current.user
  end
end
