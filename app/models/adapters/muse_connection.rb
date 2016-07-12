class Adapters::MuseConnection
  def query(params)
    HTTParty.get("https://api-v2.themuse.com/jobs?api_key=#{secret_key}&#{params}&page=1")
  end

  private

  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end
end
