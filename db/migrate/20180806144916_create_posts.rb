class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, :limit => 100
      t.string :contents, :limit => 500
      t.integer :price
      t.binary :picture, :limit => (16*1024*1024 - 1)
    end
  end
end
