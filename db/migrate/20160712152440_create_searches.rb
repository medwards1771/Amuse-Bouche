class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.text  :company_list,    default: ''
      t.text  :category_list, default: ''
      t.text  :level_list, default: ''
      t.text  :location_list, default: ''

      t.timestamps null: false
    end
  end
end
