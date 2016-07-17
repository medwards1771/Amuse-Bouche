class SearchesController < ApplicationController
  attr_reader :job_results

  def new
    @search = Search.new
    @companies = Company.all
  end

  def create
    @search = Search.create(search_params)
    job_results = Adapters::JobClient.new(search_params).results
    job_results.map do |job|
      JobResult.create(job_result_params(job, @search.id))
    end
    redirect_to search_job_results_path(@search)
  end

  private

  def search_params
    params[:search].permit(categories: [], companies: [], levels: [], locations: [])
  end

  def job_result_params(job, search_id)
    { uid: job['id'].to_i,
      title: job['name'],
      landing_page: job['refs']['landing_page'],
      company_name: job['company']['name'],
      company_id: job['company']['id'],
      search_id: search_id
    }
  end
end
