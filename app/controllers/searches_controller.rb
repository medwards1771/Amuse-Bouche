class SearchesController < ApplicationController

  def show
    @search = Search.find(params[:id])
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to(search_path(@search), notice: 'The search was saved.')
    else
      render :new, error: 'The search was not saved.'
    end
  end

  private

  def search_params
    params[:search].permit(:company_list, :category_list, :level_list, :location_list)
  end
end

