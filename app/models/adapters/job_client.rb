class Adapters::JobClient
  attr_accessor :clean_params

  def initialize(search_params)
    querify(search_params)
  end

  def query_api
    connection.query('/jobs', 1, params=clean_params)
  end

  private

  def connection
    @connection ||= Adapters::MuseConnection.new
  end

  def querify(search_params)
    companies = add_plusses(search_params[:companies])
    categories = add_ampersand(search_params[:categories])
    levels = add_plusses(search_params[:levels])
    locations = add_commas_plusses(search_params[:locations])
    test1 = companies.gsub(',', '&').split(' ')
    test2 = categories.gsub(',', '&').split(' ')
    test3 = levels.gsub(',', '&').split(' ')
    test4 = locations.gsub(',', '&').split(' ')
    company_params = test1.map{ |elem| "company=" + "#{elem}" }.join('')
    category_params = test2.map{ |elem| "category=" + "#{elem}" }.join('')
    level_params = test3.map{ |elem| "level=" + "#{elem}" }.join('')
    location_params = test4.map{ |elem| "location=" + "#{elem}" }.join('')
    array = [company_params, category_params, level_params, location_params].reject!(&:empty?)
    @clean_params = array.map{ |elem| "&#{elem}"}.join('')
  end

  def add_plusses(array)
    array.map{ |elem| elem.gsub(' ', '+') }.join(', ')
  end

  def add_ampersand(array)
    array.map{ |elem| elem.gsub(' & ', '+%26+') }.join(', ')
  end

  def add_commas_plusses(array)
    array.map do |elem|
      elem.gsub(',', '%2C').gsub(' ', '+')
    end.join(', ')
  end
end
