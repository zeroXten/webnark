class ReportChoicesController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
  before_action :set_report_choice, only: [:show, :edit, :update, :destroy]

  # GET /report_choices
  # GET /report_choices.json
  def index
    @report_choices = ReportChoice.all
  end

  # GET /report_choices/1
  # GET /report_choices/1.json
  def show
  end

  # GET /report_choices/new
  def new
    @report_choice = ReportChoice.new
  end

  # GET /report_choices/1/edit
  def edit
  end

  # POST /report_choices
  # POST /report_choices.json
  def create
    @report_choice = ReportChoice.new(report_choice_params)

    respond_to do |format|
      if @report_choice.save
        format.html { redirect_to @report_choice, notice: 'Report choice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report_choice }
      else
        format.html { render action: 'new' }
        format.json { render json: @report_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_choices/1
  # PATCH/PUT /report_choices/1.json
  def update
    respond_to do |format|
      if @report_choice.update(report_choice_params)
        format.html { redirect_to @report_choice, notice: 'Report choice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_choices/1
  # DELETE /report_choices/1.json
  def destroy
    @report_choice.destroy
    respond_to do |format|
      format.html { redirect_to report_choices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_choice
      @report_choice = ReportChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_choice_params
      params.require(:report_choice).permit(:report_item_id, :name, :bonus, :points, :description, :help)
    end
end
