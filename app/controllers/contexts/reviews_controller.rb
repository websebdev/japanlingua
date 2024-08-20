class Contexts::ReviewsController < Contexts::BaseController
  before_action :require_login

  def index
    @reviews = Current.user.reviews
      .where("next_review_date <= ?", Time.current.end_of_day)
      .where(context: @context)
      .includes(:word, :context)
      .order(:next_review_date)

    if @reviews.first
      redirect_to context_review_path(@context, @reviews.first)
    else
      redirect_to context_path(@context), notice: "No reviews due."
    end
  end

  def show
    @review = Current.user.reviews.find(params[:id])
  end

  def update
    @review = Current.user.reviews.find(params[:id])
    known = ActiveModel::Type::Boolean.new.cast(params[:known])
    srs_service = SrsSystem.new(Current.user)
    srs_service.process_review(@review, known)

    redirect_to context_reviews_path(@context)
  end

  private

  def require_login
    redirect_to signin_path unless Current.user
  end
end
