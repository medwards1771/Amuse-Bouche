class SearchesController < ApplicationController

  def show
    @search = Search.find(params[:id])
    @jobs = @search.get_results
  end

  def new
    @search = Search.new
    @companies = Company.all
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to search_path(@search)
    else
      render :new, error: 'The search was not saved.'
    end
  end

  private

  def search_params
    params[:search].permit(categories: [], companies: [], levels: [], locations: [])
  end
end
