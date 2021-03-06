class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy, :approve]

  # GET /news
  # GET /news.json
  def index
    @news = News.order(params[:release]).paginate(page: params[:page], per_page: 16)
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end
  
  def mod 
    @news = News.where(state: false).order(params[date: :asc]).paginate(page: params[:page], per_page: 8)
  end
  
  def record
      @news = News.where(state: true).order(params[date: :asc]).paginate(page: params[:page], per_page: 8)
  end
  
  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news.origin, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news.origin }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to '/modnoticias', notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def approve
    @news.update(state: true)
    respond_to do |format|
      format.html { redirect_to '/modnoticias', notice: 'News was successfully updated.' }
      format.json { head :no_content }
    end
  end  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_params
      params.require(:news).permit(:title, :link, :release, :email, :origin_id, :origin_type, :state)
    end
end
