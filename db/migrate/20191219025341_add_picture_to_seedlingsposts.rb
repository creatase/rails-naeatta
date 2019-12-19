class AddPictureToSeedlingsposts < ActiveRecord::Migration[5.2]
  def change
    add_column :seedlingsposts, :picture, :string
  end
end
