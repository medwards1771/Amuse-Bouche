class Adapters::MuseConnection
  def query(endpoint, page, params = nil)
    HTTParty.get("https://api-v2.themuse.com#{endpoint}?api_key=#{secret_key}#{params}&page=#{page}")
  end

  private

  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end
end
