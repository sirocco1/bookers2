class AddAvatarImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_image_id, :string
  end
end
