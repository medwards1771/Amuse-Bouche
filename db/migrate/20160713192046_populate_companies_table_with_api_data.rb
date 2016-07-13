class PopulateCompaniesTableWithApiData < ActiveRecord::Migration[5.0]
  def change
    company_client = Adapters::CompanyClient.new
    company_client.populate_database(Array(0..24)) 
  end
end
