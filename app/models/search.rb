class Search < ActiveRecord::Base
  attr_reader :company_data, :category_data, :level_data, :location_data, :jobs, :job_objects, :job_count

  def get_results
    job_client ||= Adapters::JobClient.new(data)
    @jobs = job_client.job_results
    if job_count > 20
      @job_objects = create_jobs(jobs[0..49])
    else
      @job_objects = create_jobs(jobs)
    end
  end

  def job_count
    jobs.count
  end

  private

  def data
    {
      companies: company_data,
      categories: category_data,
      levels: level_data,
      locations: location_data
    }
  end

  def company_data
    @company_data = self.companies == "" ? [] : JSON.parse(self.companies)
  end

  def category_data
    @category_data = self.categories == "" ? [] : JSON.parse(self.categories)
  end

  def level_data
    @level_data = self.levels == "" ? [] : JSON.parse(self.levels)
  end

  def location_data
    @location_data = self.locations == "" ? [] : JSON.parse(self.locations)
  end

  def create_jobs(jobs)
    jobs.map do |job|
      @job = Job.new(
        { uid: job['id'].to_i,
          title: job['name'],
          landing_page: job['refs']['landing_page'],
          company: job['company']['name'],
          company_id: job['company']['id']
        })
    end
  end
end