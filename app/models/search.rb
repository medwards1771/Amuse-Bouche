class Search < ActiveRecord::Base
  def company_results
    response = Adapters::JobClient.new(self.company_list).search
    response['results']
  end
end