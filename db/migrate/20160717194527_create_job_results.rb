class CreateJobResults < ActiveRecord::Migration[5.0]
  def change
    create_table :job_results do |t|
      t.integer :uid
      t.string :title
      t.string :landing_page
      t.integer :company_id
      t.string :company_name
      t.integer :search_id

      t.timestamps null: false
    end
  end
end
