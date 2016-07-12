class Adapters::MuseConnection
  def query
    HTTParty.get("https://api-v2.themuse.com/jobs?api_key=#{secret_key}&category=Data+Science&category=Engineering&level=Mid+Level&location=New+York+City+Metro+Area&page=1")
  end

  private

  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end
end