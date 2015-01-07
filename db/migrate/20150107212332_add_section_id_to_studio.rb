class AddSectionIdToStudio < ActiveRecord::Migration
  def change
    add_column :studios, :section_num, :string
  end
end
