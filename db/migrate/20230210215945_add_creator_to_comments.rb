class AddCreatorToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :creator, :string, limit: 50
  end
end
