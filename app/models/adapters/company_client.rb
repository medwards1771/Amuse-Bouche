class Adapters::CompanyClient

  def populate_database(pages)
    responses = pages.map do |page|
      connection.query(endpoint='/companies', page=page)
    end
    companies = clean(responses)
    create_companies(companies)
  end

  private

  def create_companies(companies)
    companies.each do |company|
      @company = Company.create!(company_params(company))
    end
  end

  def company_params(company)
    { uid: company['id'],
      short_name: company['short_name'],
      name: company['name']
    }
  end

  def connection
    @connection ||= Adapters::MuseConnection.new
  end

  def clean(responses)
    responses.map{ |response| response['results']}.flatten
  end
end
