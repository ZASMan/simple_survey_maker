class QuestionsController < ApplicationController
  before_action :require_login, only: [:new, :create, :index, :edit, :update, :destroy]
  before_action :redirect_if_auto_flagged_unless_is_god, only: [:edit, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    @answer = Answer.new
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private
  
  def redirect_if_contains_autoflagged_answers
    return unless signed_in?
    if @question.has_autoflagged_answers?
      unless current_user.god == true
        flash[:notice] = "Only super admins can view auto flagged posts"
        redirect_to root_url
      end
    end
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    params.require(:question).permit(:title, :description, :survey_id)
  end
end
