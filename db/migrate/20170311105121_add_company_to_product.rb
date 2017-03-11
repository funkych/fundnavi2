class AddCompanyToProduct < ActiveRecord::Migration
  def change
   add_column :products, :company, :text
   add_column :products, :category, :string
   add_column :products, :investarea, :string

  end
end
