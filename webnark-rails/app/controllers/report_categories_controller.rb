class ReportCategoriesController < ApplicationController
  before_action :set_report_category, only: [:show, :edit, :update, :destroy]

  # GET /report_categories
  # GET /report_categories.json
  def index
    @report_categories = ReportCategory.all
  end

  # GET /report_categories/1
  # GET /report_categories/1.json
  def show
  end

  # GET /report_categories/new
  def new
    @report_category = ReportCategory.new
  end

  # GET /report_categories/1/edit
  def edit
  end

  # POST /report_categories
  # POST /report_categories.json
  def create
    @report_category = ReportCategory.new(report_category_params)

    respond_to do |format|
      if @report_category.save
        format.html { redirect_to @report_category, notice: 'Report category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @report_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_categories/1
  # PATCH/PUT /report_categories/1.json
  def update
    respond_to do |format|
      if @report_category.update(report_category_params)
        format.html { redirect_to @report_category, notice: 'Report category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_categories/1
  # DELETE /report_categories/1.json
  def destroy
    @report_category.destroy
    respond_to do |format|
      format.html { redirect_to report_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_category
      @report_category = ReportCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_category_params
      params.require(:report_category).permit(:name, :description, :icon_url)
    end
end
