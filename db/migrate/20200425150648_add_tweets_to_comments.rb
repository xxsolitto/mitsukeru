class AddTweetsToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :tweet, null: false, foreign_key: true
  end
end
