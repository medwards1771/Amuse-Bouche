class JobResult < ActiveRecord::Base
  belongs_to :search
  attr_reader :connection

  def company_website
    connection['refs']['landing_page']
  end

  def company_pic
    connection['refs']['f1_image']
  end

  private

  def connection
    @connection ||= HTTParty.get("https://api-v2.themuse.com/companies/#{company_id}?api_key=#{secret_key}")
  end

  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end
end
