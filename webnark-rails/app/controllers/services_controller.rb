class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :full, :edit, :update, :destroy]
  before_action :calculate_score, only: [:show, :full]
  after_action :calculate_score, only: [:create, :update]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  def search
    @services = Service.where("name LIKE ? OR url LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    render :index
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @good = []
    @bad = []
    @service.answers.each do |answer|
      if answer.report_choice.points > 0
        @good << answer.report_choice
      else
        @bad << answer.report_choice
      end
    end
  end

  # GET /services/1/full
  def full
    @full_report = true; 

    @answers = {}

    @service.answers.each do |answer|
      category = answer.report_choice.report_item.report_category

      if not @answers.has_key? category.name
        @answers[category.name] = []
      end
      @answers[category.name] << answer
    end

    render :show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
    @report_categories = ReportCategory.all
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service }
      else
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    #params[:service][:answers_attributes].delete_if { |k,v| v.has_key?(:notes) and v[:notes].empty? and v.has_key?(:id) }
    params[:service][:answers_attributes].each_pair do |k,v|
      params[:service][:answers_attributes][k]["_destroy"] = true if v.has_key?(:id) and v.has_key?(:notes) and v[:notes].empty?
    end
    logger.info "XXXXXXXXXX"
    logger.info params
    logger.info "YYYYYYYYYY"

    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    def set_score(hash, key, points)
      if not hash.has_key? key
        hash[key] = { "good" => 0, "bad" => 0, "total" => 0, "min" => 0, "max" => 0}
      end

      if points < 0
        hash[key]["bad"] += -1 * points
        hash[key]["min"] = points if points < hash[key]["min"] 
      elsif points > 0
        hash[key]["good"] += points
        hash[key]["max"] = points if points > hash[key]["max"]
      end
      hash[key]["total"] += points
    end

    def calculate_score

      @service_scores = {}
      @category_scores = {}
      @categories = {}

      categories = []
      @service.answers.each do |answer|
        category = answer.report_choice.report_item.report_category
        if not @categories.has_key? category.name
          @categories[category.name] = category
        end

        set_score(@service_scores, category.name, answer.report_choice.points)
      end

      @categories.each_pair do |name, category|
        category.report_items.each do |item|
          item.report_choices.each do |choice|
            set_score(@category_scores, name, choice.points)
          end        
        end
      end

      score = 0
      total = 0
      @service_scores.each_pair do |category, service_score|
        adjustment = @category_scores[category]["min"] * -1
        score += service_score["total"] + adjustment
        total += @category_scores[category]["max"] + adjustment
      end

      # Check whether the score has already been set recent
      #if not @service.score or @service.score_updated_at < 1.day.ago
      score = score.to_f / total.to_f
      if @service.score != score
        @service.score = score
        @service.score_updated_at = Time.now
        @service.save
      end

    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(
        :name, 
        :description, 
        :url, 
        :slug, 
        :hosting_provider, 
        :country, 
        :screenshot_url,
        :answers_attributes => [:id, :service_id, :notes, :report_choice_id, '_destroy']
      )
    end
end
