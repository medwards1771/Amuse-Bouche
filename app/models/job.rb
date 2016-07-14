class Job
  include ApplicationHelper
  attr_accessor :uid, :title, :landing_page, :company, :company_website, :company_pic

  def initialize(options)
    @uid = options[:uid]
    @title = options[:title]
    @landing_page = options[:landing_page]
    @company = options[:company]
    @company_website = find_website(options[:company_id])
    @company_pic = find_picture(options[:company_id])
  end

  def find_website(company_id)
    HTTParty.get("https://api-v2.themuse.com/companies/#{company_id}?api_key=#{secret_key}")['refs']['landing_page']
  end

  def find_picture(company_id)
    HTTParty.get("https://api-v2.themuse.com/companies/#{company_id}?api_key=#{secret_key}")['refs']['f1_image']
  end
end
