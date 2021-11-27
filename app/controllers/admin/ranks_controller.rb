class Admin::RanksController < ApplicationController
  before_action :set_admin_rank, only: %i(show edit update destroy)

  # GET /admin/ranks or /admin/ranks.json
  def index
    @admin_ranks = Rank.all
  end

  # GET /admin/ranks/1 or /admin/ranks/1.json
  def show
  end

  # GET /admin/ranks/new
  def new
    @admin_rank = Rank.new
  end

  # GET /admin/ranks/1/edit
  def edit
  end

  # POST /admin/ranks or /admin/ranks.json
  def create
    @admin_rank = Rank.new(admin_rank_params)

    respond_to do |format|
      if @admin_rank.save
        format.html { redirect_to admin_rank_path(@admin_rank), notice: "Rank was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/ranks/1 or /admin/ranks/1.json
  def update
    respond_to do |format|
      if @admin_rank.update(admin_rank_params)
        format.html { redirect_to admin_rank_path(@admin_rank), notice: "Rank was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/ranks/1 or /admin/ranks/1.json
  def destroy
    @admin_rank.destroy
    respond_to do |format|
      format.html { redirect_to admin_ranks_url, notice: "Rank was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_rank
    @admin_rank = Rank.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_rank_params
    params.require(:rank).permit(
      :rank,
      :experience_point
    )
  end
end
