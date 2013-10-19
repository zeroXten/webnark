class ReportItemsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
  before_action :set_report_item, only: [:show, :edit, :update, :destroy]

  # GET /report_items
  # GET /report_items.json
  def index
    @report_items = ReportItem.all
  end

  # GET /report_items/1
  # GET /report_items/1.json
  def show
  end

  # GET /report_items/new
  def new
    @report_item = ReportItem.new
  end

  # GET /report_items/1/edit
  def edit
  end

  # POST /report_items
  # POST /report_items.json
  def create
    @report_item = ReportItem.new(report_item_params)

    respond_to do |format|
      if @report_item.save
        format.html { redirect_to @report_item, notice: 'Report item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @report_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_items/1
  # PATCH/PUT /report_items/1.json
  def update
    respond_to do |format|
      if @report_item.update(report_item_params)
        format.html { redirect_to @report_item, notice: 'Report item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_items/1
  # DELETE /report_items/1.json
  def destroy
    @report_item.destroy
    respond_to do |format|
      format.html { redirect_to report_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_item
      @report_item = ReportItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_item_params
      params.require(:report_item).permit(:report_category_id, :name, :help)
    end
end
