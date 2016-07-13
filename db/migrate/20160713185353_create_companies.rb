class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :uid
      t.string :name
      t.string :short_name
    end
  end
end
