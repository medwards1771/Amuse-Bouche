class Search < ActiveRecord::Base


# ADD THIS AS A COLUMN TO THE DATABASE???
# after creating a new search, update_column with huge long text?
  def job_results
    response = Adapters::JobClient.new(data).query_api
    jobs = create_jobs(response['results'])
  end

  private

  def data
    {
      companies: self.company_list.split(", "),
      categories: self.category_list.split(", "),
      levels: self.level_list.split(", "),
      locations: self.location_list.split(", ")
    }
  end

  def create_jobs(jobs)
    jobs.map do |job|
      @job = Job.new(
        { uid: job['id'],
          title: job['name'],
          landing_page: job['refs']['landing_page'],
          company: job['company']['name'],
          company_id: job['company']['id']
        })
    end
  end
end