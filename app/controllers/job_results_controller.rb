class JobResultsController < ApplicationController
  def index
    @search = Search.find(params[:search_id])
    @job_results = @search.job_results
  end
end