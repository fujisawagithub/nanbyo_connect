class DiseasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_disease, only: %i[ show edit update destroy ]
  before_action :set_q, only: [:index, :search]

  def index
    @diseases = Disease.all
  end

  def show
    @comments = @disease.comments
    @comment = @disease.comments.build
  end

  def new
    @disease = Disease.new
  end

  def edit
  end

  def create
    @disease = Disease.new(disease_params)

    respond_to do |format|
      if @disease.save
        format.html { redirect_to disease_url(@disease), notice: "Disease was successfully created." }
        format.json { render :show, status: :created, location: @disease }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @disease.update(disease_params)
        format.html { redirect_to disease_url(@disease), notice: "Disease was successfully updated." }
        format.json { render :show, status: :ok, location: @disease }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @disease.destroy

    respond_to do |format|
      format.html { redirect_to disease_url, notice: "Disease was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @results = @q.result
  end

  private
  def set_q
    @q = Disease.ransack(params[:q])
  end

  def set_disease
    @disease = Disease.find(params[:id])
  end

  def disease_params
    params.require(:disease).permit(:id, :name, :number)
  end
end
