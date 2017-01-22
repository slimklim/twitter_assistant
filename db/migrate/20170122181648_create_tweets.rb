class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :message
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
