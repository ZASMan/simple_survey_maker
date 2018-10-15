class AnswersController < ApplicationController
  # New/Create are accessible by unauthenticated user
  before_action :redirect_if_flagged_unless_god, only: [:edit, :show]
  before_action :require_login, only: [:show, :index, :edit, :update, :destroy]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      if signed_in?
        redirect_path = answers_path
      else
        redirect_path = question_path(@answer.question)
      end
      notice_message = 'Your response was succesfully saved.' +
      ' If it meets community guidelines, it will be posted soon.'
      redirect_to(
        redirect_path,
        notice: notice_message
      ) and return
    else
      redirect_to(
        question_path(@answer.question),
        notice: "Your answer cannot be saved. #{@answer.errors.messages}"
      ) and return
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      redirect_to(
        answers_path,
        notice: "Successfully updated answer."
      ) and return
    else
      redirect_to(
        edit_answer_path(@answer),
        notice: "Unable to update answer."
      ) and return
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    redirect_to answers_url, notice: 'Answer was successfully destroyed.'
  end

  private
  
  def redirect_if_flagged_unless_god
    if signed_in?
      if @answer.flagged?
        unless current_user.god == true
          flash[:notice] = "Flagged answers are only viewable by super admins"
          redirect_to root_url
        end
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def answer_params
      params.require(:answer).permit(:body, :question_id, :status)
    end
end
