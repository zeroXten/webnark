class ServicesController < ApplicationController
  # The order matters
  #before_filter :authenticate_user!
  before_action :set_service, only: [:show, :full, :edit, :update, :destroy, :report]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_action :calculate_score, only: [:show, :full]
  after_action :calculate_score, only: [:create, :update]
  after_action :get_screenshot, only: [:create, :update]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all.page(params[:page])
  end

  def search
    @services = Service.where("(name LIKE ? OR url LIKE ?) AND moderated = 't'", "%#{params[:query]}%", "%#{params[:query]}%").page(params[:page])
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
    @comments = @service.comments.recent.page(params[:page])
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

    @comments = @service.comments.recent.page(params[:page])
    render :show
  end

  # GET /services/new
  def new
    @service = Service.new
    @report_categories = ReportCategory.all
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

  def add_comment
    service = Service.friendly.find(params[:id])
    service.comments.create(comment_params)
    redirect_to :action => :show, :id => service
  end

  def report
    if user_signed_in?
      current_user.flag(@service, :abuse)
      @service.update_attributes(:flagged => true)
      redirect_to :back, notice: "Service has been reported"
    else
      redirect_to :back, alert: "You must be logged in to report services"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.friendly.find(params[:id])
    end

    def get_screenshot
      ScreenshotWorker.perform_async(@service.url,@service.slug)
    end

    def calculate_score

      @categories = {}
      @category_scores = {}
      @service_scores = {}

      @service.answers.each do |answer|
        category = answer.report_choice.report_item.report_category
        if not @categories.has_key? category.name
          @categories[category.name] = category
        end
      end

      @categories.each_pair do |name, category|

        @category_scores[name] = { :items => {}, :min => 0, :max => 0 }

        category.report_items.each do |item|

          @category_scores[name][:items][item.name] = { :min => 0, :max => 0, :bonus_min => 0, :bonus_max => 0 }
          
          item.report_choices.each do |choice|
            if choice.bonus
              if choice.points >= 0
                @category_scores[name][:items][item.name][:bonus_max] += choice.points
              else
                @category_scores[name][:items][item.name][:bonus_min] += choice.points
              end
            else
              if choice.points >= 0
                @category_scores[name][:items][item.name][:max] = [choice.points, @category_scores[name][:items][item.name][:max]].max
              else
                @category_scores[name][:items][item.name][:min] = [choice.points, @category_scores[name][:items][item.name][:min]].min
              end
            end
          end

          @category_scores[name][:min] += @category_scores[name][:items][item.name][:min] + @category_scores[name][:items][item.name][:bonus_min]
          @category_scores[name][:max] += @category_scores[name][:items][item.name][:max] + @category_scores[name][:items][item.name][:bonus_max]

        end
      end

      @service.answers.each do |answer|
        category = answer.report_choice.report_item.report_category
        points = answer.report_choice.points

        if not @service_scores.has_key? category.name
          @service_scores[category.name] = { :score => 0, :bad => 0, :good => 0 }
        end

        @service_scores[category.name][:score] += points
        if points > 0
          @service_scores[category.name][:good] += points
        else
          @service_scores[category.name][:bad] += points
        end
      end

      score = 0
      total = 0
      @service_scores.each_pair do |category, service_score|
        adjustment = @category_scores[category][:min] * -1
        score += service_score[:score] + adjustment
        total += @category_scores[category][:max] + adjustment
      end

      # Check whether the score has already been set recent
      #if not @service.score or @service.score_updated_at < 1.day.ago
      if total == 0
        score = 0
      else
        score = score.to_f / total.to_f
      end
      if @service.score != score
        @service.score = score
        @service.score_updated_at = Time.now
        @service.save
      end

    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params[:service][:answers_attributes].each_pair do |k,v|
        # Need to filter non-selected answers
        if v[:selected].to_s == "0"
          if not v[:id] or v[:id].empty?
            # No id, so ignore
            params[:service][:answers_attributes].delete(k)
          else
            # id exists, so destroy
            params[:service][:answers_attributes][k]["_destroy"] = 1
          end
        end
      end
      params.require(:service).permit(
        :name, 
        :description, 
        :url, 
        :slug, 
        :hosting_provider, 
        :country, 
        :screenshot_url,
        :answers_attributes => [:id, :service_id, :notes, :report_choice_id, :selected, '_destroy'],
      )
    end

    def comment_params
      params.require(:comment).permit(
        :title,
        :comment
      )
    end
end
