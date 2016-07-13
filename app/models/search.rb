class Search < ActiveRecord::Base
  attr_accessor :company_data, :category_data, :level_data, :location_data

# ADD THIS AS A COLUMN TO THE DATABASE???
# after creating a new search, update_column with huge long text?
  def job_results
    response = Adapters::JobClient.new(data).query_api
    jobs = create_jobs(response['results'])
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
        { uid: job['id'],
          title: job['name'],
          landing_page: job['refs']['landing_page'],
          company: job['company']['name'],
          company_id: job['company']['id']
        })
    end
  end
end