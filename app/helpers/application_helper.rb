module ApplicationHelper

  def secret_key
    @secret_key = Rails.application.secrets.muse_secret_key
  end

  def job_categories
    [
      "Account Management", "Business & Strategy", "Creative & Design", "Customer Service", "Data Science", "Editorial", "Education", "Engineering", "Finance", "Fundraising & Development", "Healthcare & Medicine", "HR & Recruiting", "Legal", "Marketing & PR", "Operations", "Project & Product Management", "Retail", "Sales", "Social Media & Community"
    ]
  end
end
