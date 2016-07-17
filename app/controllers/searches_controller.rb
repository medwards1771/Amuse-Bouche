class SearchesController < ApplicationController
  attr_reader :job_results

  def new
    @search = Search.new
    @companies = Company.all
  end

  def create
    @search = Search.create(search_params)
    @job_results = Adapters::JobClient.new(search_params).results
    @search.job_results.create(new_jobs)
    redirect_to search_job_results_path(@search)
  end

  private

  def search_params
    params[:search].permit(categories: [], companies: [], levels: [], locations: [])
  end

  def new_jobs
    job_results.map do |job|
      make_job(job, @search.id)
    end
  end

  def make_job(job, search_id)
    { uid: job['id'].to_i,
      title: job['name'],
      landing_page: job['refs']['landing_page'],
      company_name: job['company']['name'],
      company_id: job['company']['id'],
      search_id: search_id
    }
  end
end
