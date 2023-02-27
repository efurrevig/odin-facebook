class RemoveCreatorFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :creator, :string
  end
end
