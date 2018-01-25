class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # Userモデルにインデックスを持たせ、一意性を付与する
    add_index :users, :email, unique: true
  end
end
