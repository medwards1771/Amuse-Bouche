class Job
  attr_accessor :uid, :title, :landing_page, :company, :company_website

  def initialize(options)
    @uid = options[:uid]
    @title = options[:title]
    @landing_page = options[:landing_page]
    @company = options[:company]
    @company_website = find_website(options[:company_id])
  end

  def find_website(company_id)
    HTTParty.get("https://api-v2.themuse.com/companies/#{company_id}?api_key=#{secret_key}")['refs']['landing_page']
  end

  #MOVE THIS TO A COMMON PLACE, LIKE A CONFIG FILE
  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end
end
