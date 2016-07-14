class Adapters::JobClient
  attr_reader :search_params, :response, :page_count, :pages

  def initialize(search_params)
    @search_params = search_params
  end

  def job_results
    if page_count > 1
      jobs = pages.map do |page|
        connection.query('/jobs', page, params=query_params)['results']
      end.flatten
    else
      jobs = response['results']
    end
    jobs
  end

  private

  def response
     @response ||= connection.query('/jobs', 0, params=query_params)
  end

  def page_count
    @page_count ||= response['page_count']
  end

  def pages
    @pages ||= Array(0..9)
    # @pages ||= Array(0..(page_count - 1))
  end

  def connection
    @connection ||= Adapters::MuseConnection.new
  end

  def query_params
    array = [company_params, category_params].reject(&:empty?)
    array.map{ |elem| "&#{elem}" }.join('')
  end

  def company_params
    companies = search_params[:companies]
    companies = replace_spaces(companies) if companies.select{ |company| company.include?(" ") }.present?
    companies.present? ? 'company=' + companies.join('&company=') : ""
  end

  def category_params
    categories = search_params[:categories]
    categories = replace_ampersands(categories) if categories.select{ |category| category.include?("&") }.present?
    categories = replace_spaces(categories) if categories.select{ |category| category.include?(" ") }.present?
    categories.present? ? 'category=' + categories.join("&category=") : ""
  end

  def replace_spaces(array)
    array.map{ |elem| elem.gsub(' ', '+') }
  end

  def replace_ampersands(array)
    array.map{ |elem| elem.gsub('&', '%26') }
  end

  def replace_commas_plusses(array)
    array.map{ |elem| elem.gsub(',', '%2C').gsub(' ', '+') }
  end
end
