class ContentFiltersController < ApplicationController
  before_action :set_content_filter, only: [:show, :edit, :update, :destroy]

  # GET /content_filters
  def index
    @content_filters = ContentFilter.all
  end

  # GET /content_filters/1
  def show
  end

  # GET /content_filters/new
  def new
    @content_filter = ContentFilter.new
  end

  # GET /content_filters/1/edit
  def edit
  end

  # POST /content_filters
  def create
    @content_filter = ContentFilter.new(content_filter_params)

    if @content_filter.save
      redirect_to @content_filter, notice: 'Content filter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /content_filters/1
  def update
    if @content_filter.update(content_filter_params)
      redirect_to @content_filter, notice: 'Content filter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /content_filters/1
  def destroy
    @content_filter.destroy
    redirect_to content_filters_url, notice: 'Content filter was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_filter
      @content_filter = ContentFilter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_filter_params
      params.require(:content_filter).permit(:filter_list)
    end
end
