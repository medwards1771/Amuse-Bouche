class RenameColumnNamesForSearch < ActiveRecord::Migration[5.0]
  def change
    rename_column(:searches, :company_list, :companies)
    rename_column(:searches, :category_list, :categories)
    rename_column(:searches, :level_list, :levels)
    rename_column(:searches, :location_list, :locations)
  end
end
