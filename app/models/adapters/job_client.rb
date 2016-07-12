class Adapters::JobClient
  attr_accessor :company_params

  def initialize(string_params)
    querify(string_params)
  end

  def search
    connection.query(company_params)
  end

  private

  def connection
    @connection ||= Adapters::MuseConnection.new
  end

  def querify(str)
    new_string = add_plusses(str)
    test = new_string.gsub(',', '&').split(' ')
    @company_params = test.map{ |elem| "company=" + "#{elem}" }.join('')
  end

  def add_plusses(str)
    array = str.split(', ')
    array.map{ |elem| elem.gsub(' ', '+') }.join(', ')
  end
end
